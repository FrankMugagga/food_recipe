class ShoppingList < ApplicationRecord
  belongs_to :recipe
  belongs_to :inventory

  def missing_items
    return @missing_items if defined?(@missing_items)
    @missing_items = calculate_missing_items
  end

  def total_price
    missing_items.sum { |item| item[:price] }
  end

  def total_missing_items
    missing_items.count
  end

  private

  def calculate_missing_items
    recipe.foods.includes(:recipe_foods, :inventory_foods).each_with_object([]) do |food, items|
      recipe_food = find_recipe_food(food)
      inventory_food = find_inventory_food(food)
      missing_quantity = calculate_missing_quantity(recipe_food, inventory_food)

      next unless missing_quantity.positive?

      items << build_missing_item(food, recipe_food, missing_quantity)
    end
  end

  def find_recipe_food(food)
    food.recipe_foods.find { |rf| rf.recipe_id == recipe.id }
  end

  def find_inventory_food(food)
    food.inventory_foods.find { |ifood| ifood.inventory_id == inventory.id }
  end

  def calculate_missing_quantity(recipe_food, inventory_food)
    recipe_amount = recipe_food.quantity
    inventory_amount = inventory_food&.quantity || 0
    recipe_amount - inventory_amount
  end

  def build_missing_item(food, recipe_food, missing_quantity)
    {
      food: food.name,
      required: recipe_food.quantity,
      missing: missing_quantity,
      price: food.price
    }
  end
end
