class ShoppingListsController < ApplicationController
  def show
  end

  private

  def shopping_list_parameters
    params.required(:shopping_list).permit(:inventory_id)
  end
end
