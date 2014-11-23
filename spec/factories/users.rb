FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "user#{n}@primeacademy.io" }
    password "password"
    password_confirmation { "password" }    
  end
end
