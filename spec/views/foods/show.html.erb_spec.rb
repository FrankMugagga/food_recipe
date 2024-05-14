require 'rails_helper'

RSpec.describe 'inventories/index,.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    @food = @user.foods.create(user_id: @user.id, name: 'cassava', measurement_unit: 'kilogram', price: 2000)
    visit food_path(@food)
  end

  describe 'food show page' do
    
    it 'renders the food show page' do
        expect(page).to have_content(@food.name)
        expect(page).to have_content(@food.measurement_unit)
    end

    it 'redirects to the food index' do
        click_link 'Back'
        expect(page.current_path).to eq(foods_path)
      end
  end
end