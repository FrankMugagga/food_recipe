require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    
    sign_in @user
    @recipe = @user.recipes.create(user_id: @user.id, name: 'recipe one', preparation_time: 2.5, cooking_time: 3,
                                   description: 'recipe one is the very best', public: true)
    @recipe2 = @user.recipes.create(user_id: @user.id, name: 'recipe two', preparation_time: 1, cooking_time: 2,
                                    description: 'recipe two was introduced', public: false)
    visit recipes_path
  end

  describe 'recipe index page' do
    it 'renders the recipe index' do
      page.has_content?('Recipes')
      expect(page).to have_link('Add recipe', href: new_recipe_path)
      expect(page).to have_content(@recipe2.name)
      expect(page).to have_content(@recipe.name)
    end

    it 'redirects to the user index' do
      click_link 'Back'
      expect(page.current_path).to eq(users_path)
    end
  end
end
