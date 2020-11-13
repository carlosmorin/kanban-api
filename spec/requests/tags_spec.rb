require 'rails_helper'


RSpec.describe "/tags", type: :request do

  let(:valid_attributes) {
    { name: 'Contablidad' }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Tag.create! valid_attributes
      get api_v1_tags_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      tag = Tag.create! valid_attributes
      get api_v1_tag_url(tag), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Tag" do
        expect {
          post api_v1_tags_url,
               params: { tag: valid_attributes }, as: :json
        }.to change(Tag, :count).by(1)
      end

      it "renders a JSON response with the new tag" do
        post api_v1_tags_url,
             params: { tag: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Tag" do
        expect {
          post api_v1_tags_url,
               params: { tag: invalid_attributes }, as: :json
        }.to change(Tag, :count).by(0)
      end

      it "renders a JSON response with errors for the new tag" do
        post api_v1_tags_url,
             params: { tag: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Reportes' }
      }

      it "updates the requested tag" do
        tag = Tag.create! valid_attributes
        patch api_v1_tag_url(tag),
              params: { tag: new_attributes }, as: :json
        tag.reload
        expect(tag.name).to eq('Reportes')
      end

      it "renders a JSON response with the tag" do
        tag = Tag.create! valid_attributes
        patch api_v1_tag_url(tag),
              params: { tag: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the tag" do
        tag = Tag.create! valid_attributes
        patch api_v1_tag_url(tag),
              params: { tag: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested tag" do
      tag = Tag.create! valid_attributes
      expect {
        delete api_v1_tag_url(tag), as: :json
      }.to change(Tag, :count).by(-1)
    end
  end
end
