class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: { message: 'Cannot be blank' }
  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true } 
end
