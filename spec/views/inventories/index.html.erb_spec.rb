require 'rails_helper'

RSpec.describe 'inventories/index,.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')

    sign_in @user
    @inventory = @user.inventories.create(name: 'inventory one', user_id: @user.id, description: 'This inventory ....')
    @inventory1 = @user.inventories.create(name: 'inventory two', user_id: @user.id,
                                           description: 'These inventories ....')
    visit inventories_path
  end

  describe 'inventory index page' do
    it 'renders the inventory index page' do
      page.has_content?('Inventories')
      expect(page).to have_link('Create inventory', href: new_inventory_path)
      expect(page).to have_content(@inventory1.name)
      expect(page).to have_content(@inventory.name)
    end

    it 'redirects to the user index' do
      click_link 'Back'
      expect(page.current_path).to eq(users_path)
    end
  end
end
