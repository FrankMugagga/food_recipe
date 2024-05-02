class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user).where(public: true)
    @user_food_count = current_user.foods.count
    @user_food_total_price = current_user.foods.sum(:price)
  end
end
