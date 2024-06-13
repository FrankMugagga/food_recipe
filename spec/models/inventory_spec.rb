require 'rails_helper'

RSpec.describe Inventory, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')

    @inventory = @user.inventories.create(name: 'inventory one', user_id: @user.id, description: 'This inventory ....')
  end

  describe 'the inventory validity' do
    it 'is valid if all values are filed' do
      expect(@inventory).to be_valid
    end

    it 'validates the presence of each field' do
      is_expected.to validate_presence_of(:name).with_message('cannot be blank')
      is_expected.to validate_presence_of(:description).with_message('cannot be blank')
    end
  end

  describe 'the inventory relationships' do
    it 'belongs to the user' do
      expect(@inventory).to belong_to(:user)
    end

    it 'has many inventory_foods' do
      expect(@inventory).to have_many(:inventory_foods)
    end

    it 'has many foods through inventory foods' do
      expect(@inventory).to have_many(:foods).through(:inventory_foods)
    end
  end
end
