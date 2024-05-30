class PublicRecipesController < ApplicationController
  
  def index
    @recipes = Recipe.includes(:user, :recipe_foods).where(public: true)

    @recipes_data = @recipes.map do |recipe|
      total_items = recipe.recipe_foods.count(:quantity)
      total_price = recipe.recipe_foods.joins(:food).sum('foods.price')
      { recipe: recipe, total_items: total_items, total_price: total_price }
    end
  end
end
