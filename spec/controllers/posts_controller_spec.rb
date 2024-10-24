require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(email: 'user@example.com', password: 'password123', name: 'User Name') }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new post' do
        expect {
          post :create, params: { post: { title: 'New Post', body: 'Post body' } }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the new post' do
        post :create, params: { post: { title: 'New Post', body: 'Post body' } }
        expect(response).to redirect_to(Post.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new post' do
        expect {
          post :create, params: { post: { title: '', body: '' } }
        }.to_not change(Post, :count)
      end

      it 'renders the new template' do
        post :create, params: { post: { title: '', body: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { Post.create(title: 'Post to be deleted', body: 'body', user: user) }  # Associate with user

    it 'deletes the post' do
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to posts path' do
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(posts_path)
    end
  end
end
