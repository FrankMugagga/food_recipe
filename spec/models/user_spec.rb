require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(name: 'zed', email: 'zed@g.com', password: 'As@1234567', password_confirmation: 'As@1234567')
    @user.confirm
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

    it 'is invalid with a password that is too short' do
      @user.password = 'As@123'
      @user.password_confirmation = 'As@123'
      @user.valid?
      expected_message = 'password complexity requirement not met.' \
                         'Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
      expect(@user.errors[:password]).to include(expected_message)
    end

    it 'is invalid without an uppercase letter' do
      @user.password = 'as@1234567'
      @user.password_confirmation = 'as@1234567'
      @user.valid?
      expected_message = 'password complexity requirement not met.' \
                         'Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
      expect(@user.errors[:password]).to include(expected_message)
    end

    it 'is invalid without a lowercase letter' do
      @user.password = 'AS@1234567'
      @user.password_confirmation = 'AS@1234567'
      @user.valid?
      expected_message = 'password complexity requirement not met.' \
                         'Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
      expect(@user.errors[:password]).to include(expected_message)
    end

    it 'is invalid without a digit' do
      @user.password = 'AS@asdfgh'
      @user.password_confirmation = 'AS@asdfghj'
      @user.valid?
      expected_message = 'password complexity requirement not met.' \
                         'Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
      expect(@user.errors[:password]).to include(expected_message)
    end

    it 'is invalid without a special character' do
      @user.password = 'AS0asdfgh'
      @user.password_confirmation = 'AS0asdfghj'
      @user.valid?
      expected_message = 'password complexity requirement not met.' \
                         'Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
      expect(@user.errors[:password]).to include(expected_message)
    end

    it 'is invalid with if the one email add is used by different users' do
      @user1 = User.create(name: 'bod', email: 'zed@g.com', password: '1234567Y#r', password_confirmation: '1234567Y#r')
      expect(@user1).to be_invalid
      expect(@user1.errors[:email]).to include('has already been taken')
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
