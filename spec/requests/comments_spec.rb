require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/comments', type: :request do
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      title: 'Valid Title',
      body: 'Valid Body'
    }
  end

  let(:invalid_attributes) do
    {
      title: '',
      body: ''
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Comment.create! valid_attributes
      get comments_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      comment = Comment.create! valid_attributes
      get comment_url(comment)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_comment_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      comment = Comment.create! valid_attributes
      get edit_comment_url(comment)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Comment' do
        expect do
          post comments_url, params: { comment: valid_attributes }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the created comment' do
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(comment_url(Comment.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Comment' do
        expect do
          post comments_url, params: { comment: invalid_attributes }
        end.to change(Comment, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post comments_url, params: { comment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: 'New Title',
          body: 'New Body'
        }
      end

      it 'updates the requested comment' do
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: new_attributes }
        comment.reload

        expect(comment).to have_attributes(new_attributes)
      end

      it 'redirects to the comment' do
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: new_attributes }
        comment.reload
        expect(response).to redirect_to(comment_url(comment))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested comment' do
      comment = Comment.create! valid_attributes
      expect do
        delete comment_url(comment)
      end.to change(Comment, :count).by(-1)
    end

    it 'redirects to the comments list' do
      comment = Comment.create! valid_attributes
      delete comment_url(comment)
      expect(response).to redirect_to(comments_url)
    end
  end
end
