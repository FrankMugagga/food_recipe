require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
  end

  describe 'Validates presence of parameters' do
    it 'Validates the user input' do
      expect(@user).to be_valid
    end
  end
end
