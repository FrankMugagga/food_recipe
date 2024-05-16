require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    @inventory = @user.inventories.create(name: 'inventory one', user_id: @user.id, description: 'This inventory ....')
    @inventory_food = InventoryFood.create(inventory_id: @inventory.id, food_id: @food.id, quantity: 80)
  end

  describe 'Validity of the inventory_food' do
    it 'is valid if the field is filled' do
      expect(@inventory_food).to be_valid
    end

    it 'validates the presence of the quantity' do
      is_expected.to validate_presence_of(:quantity).with_message('Cannot be blank')
    end
  end

  describe 'Validity of the realtionship' do
    it 'belongs to inventory' do
      expect(@inventory_food).to belong_to(:inventory)
    end

    it 'belongs to food' do
      expect(@inventory_food).to belong_to(:food)
    end
  end
end
