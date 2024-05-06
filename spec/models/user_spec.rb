require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires password and password_confirmation fields to match' do
      user = User.new(password: 'password', password_confirmation: 'password123')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires password and password_confirmation fields when creating the model' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'ensures uniqueness of emails' do
       User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      new_user = User.new(email: 'TEST@example.com', password: 'password', password_confirmation: 'password')
      expect(new_user).not_to be_valid
      expect(new_user.errors[:email]).to include("has already been taken")
    end

    it 'requires email, first name, and last name' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
      expect(user.errors[:first_name]).to include("can't be blank")
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'requires password to have a minimum length when creating the model' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: '123', password_confirmation: '123')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")

      user.password = 'password'
      user.password_confirmation = 'password'
      expect(user).to be_valid
    end
  end
end