require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')

    sign_in @user
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    @recipe = @user.recipes.create(user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3,
                                   description: 'recipe one is the very best', public: true)
    @recipe_food = RecipeFood.create(recipe_id: @recipe.id, food_id: @food.id, quantity: 20)
  end

  describe 'GET /new' do
    before do
      get "/recipes/#{@recipe.id}/recipe_foods/new"
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'includes "Add ingredient"' do
      expect(response.body).to include('Add ingredient')
    end
  end
end
