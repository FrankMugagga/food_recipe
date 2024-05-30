class RecipeFoodsController < ApplicationController
  before_action :set_recipe, only: %i[new create destroy]
  before_action :set_recipe_food, only: [:destroy]


  def index
    @recipe_foods = RecipeFood.all
  end

  def show
    @recipe_food = RecipeFood.find(params[:id])
  end

  def new
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully added'
    else
      render :new
    end
  end

  def destroy
    @recipe_food.destroy
    redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully deleted'
  end

  private

  def set_recipe
    @recipe = current_user.recipes.find_by(id: params[:recipe_id])

    return if @recipe

    redirect_to recipes_path, alert: 'Recipe not found'
  end

  def set_recipe_food
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
