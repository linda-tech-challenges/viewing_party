require 'rails_helper'

describe User do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_confirmation_of(:password)}
  end

  describe "relationships" do
    it {should have_many(:friendships)}
    it {should have_many(:guests)}
    it {should have_many(:parties).through(:guests)}
    it {should have_many(:friends).through(:friendships)}
  end
end
