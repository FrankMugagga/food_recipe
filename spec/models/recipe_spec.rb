require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    @recipe = @user.recipes.create(user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3,
                                   description: 'recipe one is the very best', public: true)
  end

  describe 'Validity of a  recipe' do
    it 'is valid if the fields are filled' do
      expect(@recipe).to be_valid
    end

    it 'validates the presence of each field' do
      is_expected.to validate_presence_of(:name).with_message('Field cannot be blank')
      is_expected.to validate_presence_of(:preparation_time).with_message('Field cannot be blank')
      is_expected.to validate_presence_of(:cooking_time).with_message('Field cannot be blank')
      is_expected.to validate_presence_of(:description).with_message('Field cannot be blank')
    end
  end

  describe 'the recipe relationships' do
    it 'belongs to a user' do
      expect(@recipe).to belong_to(:user)
    end

    it 'has many recipe_foods' do
      expect(@recipe).to have_many(:recipe_foods).dependent(:destroy)
    end

    it 'has one shopping list' do
      expect(@recipe).to have_one(:shopping_list).dependent(:destroy)
    end

    it 'is expected to have many foods through recipe_foods' do
      expect(@recipe).to have_many(:foods).through(:recipe_foods)
    end
  end
end
