require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:valid_attributes) do
    {
      title: 'Sample Title',
      body: 'Sample Body'
    }
  end

  let(:invalid_attributes) do
    {
      title: '',
      body: ''
    }
  end

  let!(:comment) { Comment.create! valid_attributes }

  describe "GET #index" do
    it do
      get comments_path
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it do
      get comment_path(comment)
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it do
      get new_comment_path
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it do
      get edit_comment_path(comment)
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post comments_path, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the created comment" do
        post comments_path, params: { comment: valid_attributes }
        expect(response).to redirect_to(Comment.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post comments_path, params: { comment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          title: 'New Sample Title',
          body: 'New Sample Body'
        }
      end

      it "updates the requested comment" do
        expect {
          put comment_path(comment), params: { comment: new_attributes }
        }.to change { comment.reload.title }.to('New Sample Title')
          .and change{ comment.reload.body }.to('New Sample Body')
      end

      it "redirects to the comment" do
        put comment_path(comment), params: { comment: new_attributes }
        expect(response).to redirect_to(comment)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put comment_path(comment), params: { comment: invalid_attributes }

        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      expect {
        delete comment_path(comment)
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      delete comment_path(comment)
      expect(response).to redirect_to(comments_path)
    end
  end

end
