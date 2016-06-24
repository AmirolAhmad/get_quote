require 'rails_helper'

RSpec.describe Client, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:client)).to be_valid
  end

  describe 'validation' do
    it "should be valid when profile belongs to a user" do
      expect(FactoryGirl.build(:client, user: User.first)).to be_valid
    end

    it "should be invalid without contact person" do
      expect(FactoryGirl.build(:client, contactPerson: nil)).not_to be_valid
    end

    it "should be valid with contact person" do
      expect(FactoryGirl.build(:client, contactPerson: "John")).to be_valid
    end
  end
end
