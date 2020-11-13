require 'rails_helper'


RSpec.describe "/comments", type: :request do
  let(:user) { create :user }
  let(:issue) { create :issue }

  let(:valid_attributes) {
    {
      body: 'Comments bodyw',
      user_id: user.id,
      issue_id: issue.id
    }
  }

  let(:invalid_attributes) {
    {
      body: nil,
      user_id: nil,
      issue_id: nil
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Comment.create! valid_attributes
      get api_v1_comments_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      comment = Comment.create! valid_attributes
      get api_v1_comment_url(comment), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post api_v1_comments_url, params: { comment: valid_attributes }, as: :json
        }.to change(Comment, :count).by(1)
      end

      it "renders a JSON response with the new comment" do
        post api_v1_comments_url, params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post api_v1_comments_url,
               params: { comment: invalid_attributes }, as: :json
        }.to change(Comment, :count).by(0)
      end

      it "renders a JSON response with errors for the new comment" do
        post api_v1_comments_url,
             params: { comment: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { body: 'Comments body 2' }
      }

      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        patch api_v1_comment_url(comment),
              params: { comment: new_attributes }, as: :json
        comment.reload
        expect(comment.body).to eq('Comments body 2')
      end

      it "renders a JSON response with the comment" do
        comment = Comment.create! valid_attributes
        patch api_v1_comment_url(comment),
              params: { comment: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the comment" do
        comment = Comment.create! valid_attributes
        patch api_v1_comment_url(comment),
              params: { comment: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete api_v1_comment_url(comment), as: :json
      }.to change(Comment, :count).by(-1)
    end
  end
end
