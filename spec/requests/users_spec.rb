require 'rails_helper'

RSpec.describe 'Users', type: :request do
  
include Devise::Test::IntegrationHelpers

  describe 'GET /index' do
   it 'redirects to sign-in page if the user is not logged in' do
    get '/users'
    expect(response).to redirect_to(new_user_session_path)
   end

   it "renders the user's index page when a user signs in" do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    get '/users'
    expect(response).not_to redirect_to(new_user_session_path)
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:index)
    expect(response.body).to include('Welcome')
   end
  end
end
