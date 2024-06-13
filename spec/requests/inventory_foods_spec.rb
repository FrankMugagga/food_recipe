require 'rails_helper'

RSpec.describe 'InventoryFoods', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    
    sign_in @user
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    @inventory = @user.inventories.create(name: 'inventory one', user_id: @user.id, description: 'This inventory ....')
    @inventory_food = InventoryFood.create(inventory_id: @inventory.id, food_id: @food.id, quantity: 80)
  end

  describe 'GET /new' do
    it 'returns http success' do
      get "/inventories/#{@inventory.id}/inventory_foods/new"
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get "/inventories/#{@inventory.id}/inventory_foods/new"
      expect(response).to render_template(:new)
    end

    it 'includes "Add food to inventory"' do
      get "/inventories/#{@inventory.id}/inventory_foods/new"
      expect(response.body).to include('Add food to inventory')
    end
  end
end
