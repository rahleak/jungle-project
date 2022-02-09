require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should create valid user' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@email.com",
        password: "password",
        password_confirmation: "password"
        )
      expect(@user).to (be_valid)
    end

    it 'should have password and password confirmation' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@email.com",
        password: "password",
        password_confirmation: nil
        )
      expect(@user).to_not (be_valid)
    end

    it 'should not save without a unique email' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@email.com",
        password: "password"
        )
      @user2 = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@email.com",
        password: "password"
        )
      expect(@user2).to_not be_valid
    end

    it 'should have matching password and password confirmation' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@email.com",
        password: "password",
        password_confirmation: "passw0rd"
        )
      expect(@user).to_not be_valid
    end

    it 'should have name to be a valid user' do
      @user = User.new(
        first_name: nil,
        last_name: nil,
        email: "test@email.com",
        password: "password",
        password_confirmation: "password"
        )
      expect(@user).to_not (be_valid)
    end

    it 'should have a password with a minimum length of 5' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@email.com",
        password: "passw",
        password_confirmation: "passw"
        )
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'login succesfully when registered user enters correct email and password' do
      @user = User.create(
        first_name: "first_name", 
        last_name: "last_name", 
        email: "test@email.com", 
        password:"password", 
        password_confirmation:"password"
        )
    expect(User.authenticate_with_credentials("test@email.com", "password")).to eql(@user)
  end

  it 'login successfully and not be case sensitive' do
    @user = User.create(
      first_name: "first_name", 
      last_name: "last_name", 
      email: "test@email.com", 
      password: "password", 
      password_confirmation: "password"
      )
    expect(User.authenticate_with_credentials("TEST@email.com", "password")).to eq(@user)
  end

  it 'login successfully ignoring leading or trailing spaces in email' do
      @user = User.create(
        first_name: "first_name", 
        last_name: "last_name", 
        email: "test@email.com", 
        password:"password", 
        password_confirmation: "password"
        )
    expect(User.authenticate_with_credentials("  test@email.com", "password")).to eq(@user)
  end
end
end
