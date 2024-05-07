require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    @inventory = @user.inventories.create(name: 'inventory one', user_id: @user.id, description: 'This inventory ....')
  end

  describe 'GET /index,' do
    it 'returns http success' do
      get '/inventories'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/inventories'
      expect(response).to render_template(:index)
    end

    it 'includes Inventories' do
      get '/inventories'
      expect(response.body).to include('Inventories')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/inventories/#{@inventory.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get "/inventories/#{@inventory.id}"
      expect(response).to render_template(:show)
    end

    it 'includes @inventory.name' do
      get "/inventories/#{@inventory.id}"
      expect(response.body).to include(@inventory.name.to_s)
    end
  end

  describe 'GET /new,' do
    it 'returns http success' do
      get '/inventories/new'
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get '/inventories/new'
      expect(response).to render_template(:new)
    end

    it 'includes Create Inventory' do
      get '/inventories/new'
      expect(response.body).to include('Create Inventory')
    end
  end

end
