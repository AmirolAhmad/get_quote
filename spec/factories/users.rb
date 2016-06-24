FactoryGirl.define do
  factory :user do |n|
    email {|n| "person#{n}@example.com" }
    username {|n| "username#{n}"}
    password 'secret123'
    password_confirmation 'secret123'
    confirmed_at Date.today
    admin 0
    factory :admin do
      admin 1
    end
  end
end
