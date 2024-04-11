class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe= Recipe.find(params[:id])
  end

  def new
    @user = User.find(params[:id])
    @recipe = Recipe.new(recipe_params)
  end

  def create
    @user = User.find(params[:id])
    @recipe= Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfull created'
    else
      render :new
    end
  end

  def destroy
    @recipe= recipe.find(params[:id])
    @inventory.destroy
    redirect_to recipes_url, notice: 'Inventory was successfully destroyed'
  end

  private

  def recipe_params
    params.required(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
