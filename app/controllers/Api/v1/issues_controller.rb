module Api
  module V1
    class IssuesController < ApplicationController
      before_action :set_issue, only: [:show, :update, :destroy, :update_status]

      # GET /issues
      def index
        params[:q] ||= {}
        @issues = Issue.ransack(params[:q])
        # filters
        render json: @issues.result
      end

      # GET /issues/1
      def show
        render json: @issue, show_comments: true
      end

      # POST /issues
      def create
        @issue = Issue.new(issue_params)

        if @issue.save
          render json: @issue, status: :created
        else
          render json: @issue.errors, status: :unprocessable_entity
        end
      end

      def tags
        return unless params[:tag_id].present? || params[:issue_id].present?
        query = "INSERT INTO issues_tags (issue_id, tag_id) VALUES
          (#{params[:issue_id]}, #{params[:tag_id]})"
        ActiveRecord::Base.connection.exec_query(query)
      end

      # PATCH/PUT /issues/1
      def update
        if @issue.update(issue_params)
          render json: @issue
        else
          render json: @issue.errors, status: :unprocessable_entity
        end
      end

      def update_status 
        if @issue.update(status: params[:status])
          render json: @issue
        else
          render json: @issue.errors, status: :unprocessable_entity
        end
      end
      # DELETE /issues/1
      def destroy
        @issue.destroy
      end

      private
        def filters
          filter_by_category if params[:category_id].present?
          filter_by_user if params[:user_id].present?
          filter_by_project if params[:project_id].present?
          filter_by_status if params[:status].present?
          serach if params[:query].present?
          sort if params[:sort].present?
        end

        def filter_by_category
          @issues = @issues.where(category_id: params[:category_id])
        end

        def filter_by_user
          @issues = @issues.where(user_id: params[:user_id])
        end

        def filter_by_project
          @issues = @issues.where(project_id: params[:project_id])
        end

        def filter_by_status
          @issues = @issues.where(status: params[:status])
        end

        def serach
          query = Regexp.escape(params[:query])
          @issues = @issues.where("concat(subject, ' ', description) ~* ?", query)
        end

        def sort
          @issues = @issues.order(created_at: params[:sort])
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_issue
          id = params[:id].present? ? params[:id] : params[:issue_id] 
          @issue = Issue.find(id)
        end

        # Only allow a trusted parameter "white list" through.
        def issue_params
          params.require(:issue).permit(:subject, :description, :status,
              :due_date, :user_id, :category_id, :project_id)
        end
    end
  end
end
