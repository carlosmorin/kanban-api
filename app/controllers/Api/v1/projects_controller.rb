module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_project, only: [:show, :update, :destroy]

      # GET /projects
      def index
        @projects = Project.all

        render json: @projects
      end

      # GET /projects/1
      def show
        render json: @project
      end

      # POST /projects
      def create
        @project = Project.new(project_params)

        if @project.save
          render json: @project, status: :created
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /projects/1
      def update
        if @project.update(project_params)
          render json: @project
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # DELETE /projects/1
      def destroy
        @project.destroy
      end

      def members
        return unless params[:project_id].present? || params[:user_id].present?
        query = "INSERT INTO projects_users (project_id, user_id) VALUES
          (#{params[:project_id]}, #{params[:user_id]})"
        ActiveRecord::Base.connection.exec_query(query)
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_project
          @project = Project.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def project_params
          params.require(:project).permit(:name, :description)
        end
    end
  end
end
