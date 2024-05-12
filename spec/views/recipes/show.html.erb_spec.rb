require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
    @recipe = @user.recipes.create(user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3,
                                   description: 'recipe one is the very best', public: true)
    visit recipe_path(@recipe)
  end

  describe 'recipe show' do
    it 'renders the recipe show' do
      expect(page).to have_content(@recipe.name)
      expect(page).to have_link( 'Add ingredient', href: new_recipe_recipe_food_path(@recipe) )
      expect(page).to have_link( 'Generate shopping list', href: new_recipe_shopping_list_path(@recipe))
    end

    it 'redirects to the recipe index' do
      click_link 'Back'
      expect(page.current_path).to eq(recipes_path)
    end
  end
end
