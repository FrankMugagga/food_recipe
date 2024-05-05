require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    @recipe = @user.recipes.create( user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3, description: 'recipe one is the very best', public: true )
    @recipe_food = RecipeFood.create( recipe_id: @recipe.id, food_id: @food.id, quantity: 20 )
  end

  describe 'recipe_food validity' do
    it 'is valid if the quantity is filled' do
      expect(@recipe_food).to be_valid
    end

    it 'validates the presence of the quantity' do
      is_expected.to validate_presence_of(:quantity).with_message('Cannot be blank')
    end
  end

  describe 'recipe_food relationships' do
    it 'belongs to a recipe' do
      expect(@recipe_food).to belong_to(:recipe)
    end

    it 'belongs to a food' do
      expect(@recipe_food).to belong_to(:food)
    end
  end
end
