require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create!(email: 'user@example.com', password: 'password123', name: 'User Name') }

  before do
    sign_in user
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: user.id }  # Pass the user ID here
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the user' do
        patch :update, params: { id: user.id, user: { name: 'New Name', email: 'new@example.com' } }  # Pass the user ID here
        user.reload
        expect(user.name).to eq('New Name')
        expect(user.email).to eq('new@example.com')
      end

      it 'redirects to the root path' do
        patch :update, params: { id: user.id, user: { name: 'New Name' } }  # Pass the user ID here
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Profile updated successfully.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        patch :update, params: { id: user.id, user: { email: 'invalid_email' } }  # Pass the user ID here
        user.reload
        expect(user.email).to_not eq('invalid_email')
      end

      it 'renders the edit template' do
        patch :update, params: { id: user.id, user: { email: 'invalid_email' } }  # Pass the user ID here
        expect(response).to render_template(:edit)
      end
    end
  end
end
