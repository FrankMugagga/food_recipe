require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL

  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
    expect(@user.confirmed?).to be true
    sign_in @user
  end

  describe 'user index page' do
    it 'renders the user index' do
      visit users_path
      page.has_content?(@user.name)
    end
  end
end
