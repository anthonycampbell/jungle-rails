require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.first_name = "fake"
      @user.last_name = "person"
      @user.email = "user@gmail.com"
    end
    it "will save properly" do
      @user.save
      expect(User.where(:password == 'password')[0]).to eq @user
    end
    it "will not save without matching passwords" do
      @user.password_confirmation = 'pass'
      @user.save
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it "will not save without passwords" do
      @user.password = nil
      @user.save
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it "will not save without password_confirmation" do
      @user.password_confirmation = nil
      @user.save
      expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
    end
    context "email exists" do
      it "will be unique" do
        @user.save
        @new_user = User.new
        @new_user.password = "password"
        @new_user.password_confirmation = "password"
        @new_user.first_name = "second"
        @new_user.last_name = "user"
        @new_user.email = "user@GMAIL.com"
        @new_user.save
        expect(@new_user.errors.full_messages).to include "Email has already been taken"
      end
    end
    it "will require email" do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it "will require first name" do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it "will require last name" do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    context "minimum length password" do
      it "will not save with a password less than minimum lenggth" do
        @user.password = "pas"
        @user.password_confirmation = "pas"
        @user.save
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
      end
    end
  end
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.first_name = "fake"
      @user.last_name = "person"
      @user.email = "user@gmail.com"
    end
    it "will authenticate with different email casings" do 
      @user.save
      created_user = User.find_by_email("user@gmail.com")
      expect(User.authenticate_with_credentials("user@gmail.com", "password")).to eql(created_user)
    end
    it "will authenticate with whitespace surrounding email" do 
      @user.save
      created_user = User.find_by_email("user@gmail.com")
      expect(User.authenticate_with_credentials("   user@gmail.com     ", "password")).to eql(created_user)
    end
    it "will refuse to authenticate wrong email" do 
      @user.save
      created_user = User.find_by_email("user@gmail.com")
      expect(User.authenticate_with_credentials("kang@roo.com", "password")).not_to eql(created_user)
    end
  end
end