require 'rails_helper'

RSpec.describe 'inventories/index,.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    
    sign_in @user
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    @food1 = @user.foods.create(user_id: @user.id, name: 'sava', measurement_unit: 'kg', price: 800)
    visit foods_path
  end

  describe 'food index page' do
    it 'renders the food index page' do
      expect(page).to have_link('Add food', href: new_food_path)
      expect(page).to have_content(@food.name)
      expect(page).to have_content(@food1.name)
    end

    it 'redirects to the user index' do
      click_link 'Back'
      expect(page.current_path).to eq(users_path)
    end
  end
end
