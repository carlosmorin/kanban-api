require 'rails_helper'

RSpec.describe "api/v1/users", type: :request do

  let(:valid_attributes) {
    { name: 'Jose Carlos', email: 'carlosmorin78@gmail.com' }
  }

  let(:invalid_attributes) {
    { name: nil, email: nil }
  }

  describe "GET api/v1/index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get api_v1_users_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET api/v1/show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get api_v1_user_url(user), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST api/v1/create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_url, params: { user: valid_attributes }, as: :json
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post api_v1_users_url, params: { user: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_url, params: { user: invalid_attributes }, as: :json
        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        post api_v1_users_url, params: { user: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Ramiro Pérez', email: 'ramiro@gmail.com' }
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), params: { user: invalid_attributes }, as: :json
        user.reload
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), params: { user: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete api_v1_user_url(user), as: :json
      }.to change(User, :count).by(-1)
    end
  end
end
