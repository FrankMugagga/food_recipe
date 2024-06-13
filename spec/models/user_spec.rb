require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    
  end

  describe 'The user validity' do
    it 'is valid if all attributes are filled' do
      expect(@user).to be_valid
    end

    it 'validates the presence of each field' do
      is_expected.to validate_presence_of(:name).with_message("missing value, can't be blank")
      is_expected.to validate_presence_of(:email).with_message("missing value, can't be blank")
      is_expected.to validate_presence_of(:password).with_message("missing value, can't be blank")
      is_expected.to validate_presence_of(:password_confirmation).with_message("missing value, can't be blank")
    end

    it 'displays an error message if a value is missing' do
      @user.name = ''
      @user.valid?
      expect(@user).to be_invalid
      expect(@user.errors[:name]).to include("missing value, can't be blank")
    end
  end

  describe 'the user relationships' do
    it 'has many recipes' do
      expect(@user).to have_many(:recipes).dependent(:destroy)
    end

    it 'has many foods' do
      expect(@user).to have_many(:foods).dependent(:destroy)
    end

    it 'has many inventories' do
      expect(@user).to have_many(:inventories).dependent(:destroy)
    end
  end
end
