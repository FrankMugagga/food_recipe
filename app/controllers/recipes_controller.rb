class RecipesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.all
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfull created'
    else
      render :new
    end
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def update
    @recipe = current_user.recipes.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipes_path, notice: 'Recipe was successfully update'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed'
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_back(fallback_location: recipe_path)
  end

  def shopping_list
    @recipe = Recipe.find(params[:id])
    return unless @recipe.user == current_user

    @inventories = @recipe.user.inventories
  end

  private

  def recipe_params
    params.required(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
