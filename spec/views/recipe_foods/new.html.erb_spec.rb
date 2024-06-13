require 'rails_helper'

RSpec.describe 'recipe_foods/new.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    
    sign_in @user
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    @recipe = @user.recipes.create(user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3,
                                   description: 'recipe one is the very best', public: true)
    @recipe_food = RecipeFood.create(recipe_id: @recipe.id, food_id: @food.id, quantity: 20)
    visit new_recipe_recipe_food_path(@recipe)
  end

  describe 'recipe_food new page' do
    it 'renders the new_recipe_food page' do
      expect(page).to have_content('Add ingredient')
      expect(page).to have_field(@recipe_food_quantity)
      expect(page).to have_button('Add ingredient')
    end

    it 'redirects to the inventory show' do
      click_link 'Back'
      expect(page.current_path).to eq(recipe_path(@recipe))
    end
  end
end
