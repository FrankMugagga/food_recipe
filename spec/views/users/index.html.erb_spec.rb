require 'rails_helper'

Rspec.describe 'users/index', type: :view do
  include Devise::Test::IntegrationHelpers
  include Capybara::DSL 
end