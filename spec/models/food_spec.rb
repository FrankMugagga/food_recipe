require 'rails_helper'

RSpec.describe Food, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')

    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
  end

  describe 'Validity of a food' do
    it 'is valid if all fields are filled' do
      expect(@user).to be_valid
    end

    it 'validates the presence of each field' do
      is_expected.to validate_presence_of(:name).with_message('Please enter value, Cannot be blank')
      is_expected.to validate_presence_of(:measurement_unit).with_message('Please enter value, Cannot be blank')
      is_expected.to validate_presence_of(:price).with_message('Please enter value, Cannot be blank')
    end
  end

  describe 'food relationships' do
    it 'belongs to a user' do
      expect(@food).to belong_to(:user)
    end

    it 'has many recipe_foods' do
      expect(@food).to have_many(:recipe_foods).dependent(:destroy)
    end

    it 'has many recipes through recipe foods' do
      expect(@food).to have_many(:recipes).through(:recipe_foods)
    end

    it 'has many inventory_foods' do
      expect(@food).to have_many(:inventory_foods).dependent(:destroy)
    end

    it 'has many inventories' do
      expect(@food).to have_many(:inventories).through(:inventory_foods)
    end
  end
end
