require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:profile)).to be_valid
  end

  describe 'validation' do
    it "should be valid when profile belongs to a user" do
      expect(FactoryGirl.build(:profile, user: User.first)).to be_valid
    end

    it "should be invalid without first name" do
      expect(FactoryGirl.build(:profile, firstName: nil)).not_to be_valid
    end

    it "should be valid with first name" do
      expect(FactoryGirl.build(:profile, firstName: "John")).to be_valid
    end

    it "should be invalid without last name" do
      expect(FactoryGirl.build(:profile, lastName: nil)).not_to be_valid
    end

    it "should be valid with last name" do
      expect(FactoryGirl.build(:profile, lastName: "Doe")).to be_valid
    end
  end
end
