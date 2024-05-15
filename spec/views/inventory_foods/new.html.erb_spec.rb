require 'rails_helper'

RSpec.describe 'inventories/new,.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL
  
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    @inventory = @user.inventories.create(name: 'inventory one', user_id: @user.id, description: 'This inventory ....')
    @inventory_food = InventoryFood.create(inventory_id: @inventory.id, food_id: @food.id, quantity: 80)
    visit new_inventory_inventory_food_path(@inventory )
  end

  describe 'inventory_food new page' do
    it 'renders the new_inventory_food page' do
        expect(page).to have_content('Add food to inventory')
        expect(page).to have_field(@inventory_food_quantity)
        expect(page).to have_button('Create')
    end

    it 'redirects to the inventory show' do
        click_link 'Back'
        expect(page.current_path).to eq(inventory_path(@inventory))
      end
  end
end