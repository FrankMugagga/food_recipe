class ShoppingList < ApplicationRecord
  belongs_to :recipe
  belongs_to :inventory
end
