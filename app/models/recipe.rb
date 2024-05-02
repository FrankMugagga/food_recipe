class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods
  has_many :shopping_lists

  validates :name, :preparation_time, :cooking_time, description, public, presence: true
end
