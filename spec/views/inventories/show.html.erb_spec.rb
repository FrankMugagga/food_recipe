require 'rails_helper'

RSpec.describe 'inventories/show,.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    @inventory = @user.inventories.create(name: 'inventory one', user_id: @user.id, description: 'This inventory ....')
    visit inventory_path(@inventory)
  end

  describe 'inventory show page' do
    it 'renders the inventory show page' do
      expect(page).to have_content('Inventory')
      expect(page).to have_content(@inventory.name)
      expect(page).to have_link('Add Food', href: new_inventory_inventory_food_path(@inventory))
    end

    it 'redirects to the inventories index' do
      click_link 'Back'
      expect(page.current_path).to eq(inventories_path)
    end
  end
end
