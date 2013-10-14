FactoryGirl.define do
  sequence :user_submission do
    ["East 74th and Lexington, New York", "West 74th and Amsterdam, New York", "E14th and 3rd, New York"].sample
  end

  factory :location do
    user_submission
  end
end
