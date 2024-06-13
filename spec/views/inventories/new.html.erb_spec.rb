require 'rails_helper'

RSpec.describe 'inventories/new,.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')

    sign_in @user
    visit new_inventory_path
  end

  describe 'inventory new page' do
    it 'will render inventory new page' do
      expect(page).to have_content('Create Inventory')
      expect(page).to have_button('Create inventory')
      expect(page).to have_field(@inventory_name)
    end

    it 'redirects to the user index' do
      click_link 'Back'
      expect(page.current_path).to eq(inventories_path)
    end
  end
end
