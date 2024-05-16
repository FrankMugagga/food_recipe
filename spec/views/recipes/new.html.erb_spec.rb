require 'rails_helper'

RSpec.describe 'recipes/new.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    @recipe = @user.recipes.create(user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3,
                                   description: 'recipe one is the very best', public: true)
    visit new_recipe_path
  end

  describe 'recipe new' do
    it 'renders the recipe new' do
      expect(page).to have_content('Create Recipe')
      expect(page).to have_field(@recipe_preparation_time)
      expect(page).to have_button('Create recipe')
    end

    it 'redirects to the recipe index' do
      click_link 'Back'
      expect(page.current_path).to eq(recipes_path)
    end
  end
end
