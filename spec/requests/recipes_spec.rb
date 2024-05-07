require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    @recipe = @user.recipes.create(user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3,
                                   description: 'recipe one is the very best', public: true)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/recipes'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/recipes'
      expect(response).to render_template(:index)
    end

    it 'includes Recipies in the body' do
      get '/recipes'
      expect(response.body).to include('Recipes')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/recipes/#{@recipe.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get "/recipes/#{@recipe.id}"
      expect(response).to render_template(:show)
    end

    it 'includes <%= @recipe.preparation_time %> in the body' do
      get "/recipes/#{@recipe.id}"
      expect(response.body).to include(@recipe.preparation_time.to_s)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/recipes/new'
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get '/recipes/new'
      expect(response).to render_template(:new)
    end

    it 'includes Create Recipe in the body' do
      get '/recipes/new'
      expect(response.body).to include('Create Recipe')
    end
  end
end
