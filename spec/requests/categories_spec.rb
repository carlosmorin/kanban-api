require 'rails_helper'

RSpec.describe "api/v1/categories", type: :request do

  let(:valid_attributes) {
    { name: "Category 1", description: "Description 1" }
  }

  let(:invalid_attributes) {
    { name: nil, description: nil }
  }

  describe "GET api/v1/index" do
    it "renders a successful response" do
      Category.create! valid_attributes
      get api_v1_categories_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      category = Category.create! valid_attributes
      get api_v1_category_url(category), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Category" do
        expect {
          post api_v1_categories_url,
               params: { category: valid_attributes }, as: :json
        }.to change(Category, :count).by(1)
      end

      it "renders a JSON response with the new category" do
        post api_v1_categories_url,
             params: { category: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Category" do
        expect {
          post api_v1_categories_url,
               params: { category: invalid_attributes }, as: :json
        }.to change(Category, :count).by(0)
      end

      it "renders a JSON response with errors for the new category" do
        post api_v1_categories_url,
             params: { category: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "Category 2", description: "Description 2" }
      }

      it "updates the requested category" do
        category = Category.create! valid_attributes
        patch api_v1_category_url(category),
              params: { category: new_attributes }, as: :json
        category.reload
        expect(category.name).to eq('Category 2')
      end

      it "renders a JSON response with the category" do
        category = Category.create! valid_attributes
        patch api_v1_category_url(category),
              params: { category: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the category" do
        category = Category.create! valid_attributes
        patch api_v1_category_url(category),
              params: { category: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete api_v1_category_url(category), as: :json
      }.to change(Category, :count).by(-1)
    end
  end
end
