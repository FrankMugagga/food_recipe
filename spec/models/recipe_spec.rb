require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
  end

  describe 'Valide recipe' do
    it 'Validates the creation of a recipe' do
      @recipe = @user.recipes.create( user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3, description: 'recipe one is the very best', public: true )
      expect( @recipe).to be_valid
    end
  end
end
