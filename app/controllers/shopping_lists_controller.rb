class ShoppingListsController < ApplicationController
  before_action :set_recipe, only: %i[new create]
  def index
    @shopping_list = ShoppingList.all
  end

  def show
    @shopping_list = ShoppingList.find(params[:id])
    @shopping_list.total_price
    @shopping_list.total_missing_items
  end

  def new
    @shopping_list = @recipe.shopping_lists.new
  end

  def create
    @shopping_list = @recipe.shopping_lists.build(shopping_list_params)
    if @shopping_list.save
      redirect_to recipe_shopping_list_path(@recipe, @shopping_list),
                  notice: 'shopping list was successfully generated'
    else
      render :new
    end
  end

  private

  def set_recipe
    @recipe = current_user.recipes.find_by(id: params[:recipe_id])
  end

  def shopping_list_params
    params.require(:shopping_list).permit(:inventory_id)
  end
end
