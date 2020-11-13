require 'rails_helper'

RSpec.describe "api/v1/issues", type: :request do

  let(:category) { create :category }
  let(:user) { create :user }
  let(:project) { create :project }

  let(:valid_attributes) {
    {
      subject: 'Fix in the amounts report',
      description: 'Description',
      status: :pending,
      due_date: Time.zone.now + 1.week,
      user_id: user.id,
      category_id: category.id,
      project_id: project.id
    }
  }

  let(:invalid_attributes) {
    {
      subject: nil,
      description: nil,
      status: nil,
      due_date: nil,
      user_id: nil,
      category_id: nil
    }
  }

  describe "GET api/v1/issues/index" do
    it "renders a successful response" do
      Issue.create! valid_attributes
      get api_v1_issues_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      issue = Issue.create! valid_attributes
      get api_v1_issue_url(issue), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Issue" do
        expect {
          post api_v1_issues_url,
               params: { issue: valid_attributes }, as: :json
        }.to change(Issue, :count).by(1)
      end

      it "renders a JSON response with the new issue" do
        post api_v1_issues_url, params: { issue: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Issue" do
        expect {
          post api_v1_issues_url,
               params: { issue: invalid_attributes }, as: :json
        }.to change(Issue, :count).by(0)
      end

      it "renders a JSON response with errors for the new issue" do
        post api_v1_issues_url, params: { issue: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "POST /tags" do
    let(:issue) { create :issue }
    let(:tag) { create :tag }

    it "Link to a new issue with tags" do
      post api_v1_issue_tags_url(issue), params: { tag_id: tag.id }, as: :json
      expect(response).to have_http_status(204)
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { subject: 'Fix in the outstanding balances report' }
      }

      it "updates the requested issue" do
        issue = Issue.create! valid_attributes
        patch api_v1_issue_url(issue),
              params: { issue: new_attributes }, as: :json
        issue.reload
        expect(issue.subject).to eq('Fix in the outstanding balances report')
      end

      it "renders a JSON response with the issue" do
        issue = Issue.create! valid_attributes
        patch api_v1_issue_url(issue), params: { issue: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    describe "PATCH /update_status" do
      it "updates the requested issue" do
        issue = Issue.create! valid_attributes
        patch api_v1_issue_url(issue), params: { issue: {status: :todo} }, as: :json
        issue.reload
        expect(issue.status).to eq('todo')
      end
    end
    
    context "with invalid parameters" do
      it "renders a JSON response with errors for the issue" do
        issue = Issue.create! valid_attributes
        patch api_v1_issue_url(issue), params: { issue: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested issue" do
      issue = Issue.create! valid_attributes
      expect {
        delete api_v1_issue_url(issue), as: :json
      }.to change(Issue, :count).by(-1)
    end
  end
end
