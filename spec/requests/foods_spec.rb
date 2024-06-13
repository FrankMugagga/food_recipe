require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    sign_in @user
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/foods'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/foods'
      expect(response).to render_template(:index)
    end

    it 'includes "Add food"' do
      get '/foods'
      expect(response.body).to include('Add food')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/foods/#{@food.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get "/foods/#{@food.id}"
      expect(response).to render_template(:show)
    end

    it 'includes @food.name' do
      get "/foods/#{@food.id}"
      expect(response.body).to include(@food.name.to_s)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/foods/new'
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get '/foods/new'
      expect(response).to render_template(:new)
    end

    it 'includes "Add food"' do
      get '/foods/new'
      expect(response.body).to include('Add food')
    end
  end
end
