class ShoppingList < ApplicationRecord
  belongs_to :recipe
  belongs_to :inventory

  def missing_items
    return @missing_items if defined?(@missing_items)
    
    @missing_items = recipe.foods.includes(:recipe_foods, :inventory_foods).map do |food|
      item_details(food)
    end.compact
    @missing_items
  end

  private

  def item_details(food)
    recipe_food = food.recipe_foods.find { |rf| rf.recipe_id == recipe.id }
    inventory_food = food.inventory_foods.find { |ifood| ifood.inventory_id == inventory.id }
    recipe_amount = recipe_food.quantity
    inventory_amount = inventory_food&.quantity || 0

    return nil if inventory_amount >= recipe_amount

    missing_quantity = recipe_amount - inventory_amount
    {
      food: food.name,
      required: recipe_amount,
      missing: missing_quantity,
      price: food.price
    }
  end

  public

  def total_price
    missing_items.sum { |item| item[:price] }
  end

  def total_missing_items
    missing_items.count
  end
end
