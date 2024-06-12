class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  has_many :shopping_lists, dependent: :destroy

  validates :name, :preparation_time, :cooking_time, :description, presence: { message: 'Field cannot be blank' }
  validates :preparation_time, :cooking_time, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
