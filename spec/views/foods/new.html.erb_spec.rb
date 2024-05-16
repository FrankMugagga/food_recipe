require 'rails_helper'

RSpec.describe 'inventories/index,.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    visit new_food_path
  end

  describe 'food new page' do
    it 'renders the food new page' do
      expect(page).to have_content('Add food')
      expect(page).to have_field(@food_price)
      expect(page).to have_button('Add food')
    end

    it 'redirects to the recipe index' do
      click_link 'Back'
      expect(page.current_path).to eq(foods_path)
    end
  end
end
