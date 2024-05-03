class ShoppingList < ApplicationRecord
  belongs_to :recipe
  belongs_to :inventory

  def missing_items
    return @missing_items if defined?(@missing_items)

    @missing_items = []
    recipe.foods.includes(:recipe_foods, :inventory_foods).each do |food|
      recipe_food = food.recipe_foods.find { |rf| rf.recipe_id == recipe.id }
      inventory_food = food.inventory_foods.find { |ifood| ifood.inventory_id == inventory.id }
      recipe_amount = recipe_food.quantity
      inventory_amount = inventory_food&.quantity || 0

      next unless inventory_amount < recipe_amount

      missing_quantity = recipe_amount - inventory_amount
      @missing_items << {
        food: food.name,
        required: recipe_amount,
        missing: missing_quantity,
        price: food.price
      }
    end
    @missing_items
  end

  def total_price
    missing_items.sum { |item| item[:price] }
  end

  def total_missing_items
    missing_items.count
  end
end
