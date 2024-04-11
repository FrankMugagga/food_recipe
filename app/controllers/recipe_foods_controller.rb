class RecipeFoodsController < ApplicationController
  def index
    @recipe_foods = RecipeFood.all
end

def show
    @recipe_food = RecipeFood.find(params[:id])
end

def new
    @recipe_food = RecipeFood.new
end

def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
        redirect_to @recipe_food, notice: 'Recipefood was successfully created'
    else
        render :new
    end
end

def destroy
    @recipe_food = RecipeFood.find(params[:id])        
    @recipe_food.destroy
    redirect_to recipe_foods_url, notice: 'Inventory food was successfully destroyed'
end

private

def recipe_food_params
    params.require(:inventory_food).permit(:quantity, :inventory_id, :food_id)
end
end
