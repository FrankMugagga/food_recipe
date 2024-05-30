require 'rails_helper'

RSpec.describe 'public_recipes/index.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    visit public_recipes_path
  end

  describe 'public recipes index page' do
    it 'renders the public recipes index page' do
      expect(page).to have_content('Public Recipes')
    end

    it 'redirects to the users path' do
      click_link 'Back'
      expect(page.current_path).to eq(users_path)
    end
  end
end
