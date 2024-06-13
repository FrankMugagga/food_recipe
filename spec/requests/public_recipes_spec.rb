require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')

    sign_in @user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/public_recipes'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/public_recipes'
      expect(response).to render_template(:index)
    end

    it 'includes "@user_food_count "' do
      get '/public_recipes'
      expect(response.body).to include(@user_food_count.to_s)
    end
  end
end
