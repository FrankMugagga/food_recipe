class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods
  has_many :inventory_foods, dependent: :destroy
  has_many :inventories, through: :inventory_foods

  validates :name, :measurement_unit, :price, presence: { message: 'Please enter value, Cannot be blank' }
end
