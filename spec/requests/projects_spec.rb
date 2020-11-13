require 'rails_helper'

RSpec.describe "/projects", type: :request do

  let(:valid_attributes) {
    { name: 'Proyect test', description: 'Description' }
  }

  let(:invalid_attributes) {
    { name: nil, description: nil }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Project.create! valid_attributes
      get api_v1_projects_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      project = Project.create! valid_attributes
      get api_v1_project_url(project), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Project" do
        expect {
          post api_v1_projects_url,
               params: { project: valid_attributes }, as: :json
        }.to change(Project, :count).by(1)
      end

      it "renders a JSON response with the new project" do
        post api_v1_projects_url,
             params: { project: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project" do
        expect {
          post api_v1_projects_url,
               params: { project: invalid_attributes }, as: :json
        }.to change(Project, :count).by(0)
      end

      it "renders a JSON response with errors for the new project" do
        post api_v1_projects_url,
             params: { project: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "POST /members" do
    let(:project) { create :project }
    let(:user) { create :user }

    it "Link to a new user with project" do
      post api_v1_project_members_url(project), params: { user_id: user.id }, as: :json
      expect(response).to have_http_status(204)
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Proyect test 2', description: 'Description 2' }
      }

      it "updates the requested project" do
        project = Project.create! valid_attributes
        patch api_v1_project_url(project),
              params: { project: new_attributes }, as: :json
        project.reload
        expect(project.name).to eq('Proyect test 2')
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the project" do
        project = Project.create! valid_attributes
        patch api_v1_project_url(project),
              params: { project: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete api_v1_project_url(project), as: :json
      }.to change(Project, :count).by(-1)
    end
  end
end
