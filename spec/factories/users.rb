FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@test.com"
  end

  factory :user do
    email
    password "test"
    password_confirmation "test"
  end
end
