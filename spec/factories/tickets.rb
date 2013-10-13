FactoryGirl.define do
  factory :ticket do
    location
    user
    fine "100"
    officer "Officer Taco"
    issued_at Date.new(2013, 10, 10)
    status "unpaid"
  end
end

