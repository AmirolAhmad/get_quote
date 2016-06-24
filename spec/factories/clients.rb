FactoryGirl.define do
  factory :client do |n|
    user
    clientId {|n| "clientid#{n}" }
    contactPerson "MyString"
    companyName "MyString"
    companyAddress "MyString"
    email "MyString"
    phone "MyString"
  end
end
