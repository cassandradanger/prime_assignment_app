FactoryGirl.define do
  factory :admin do
    email "user@primeacademy.com"
    password "password"
    password_confirmation { "password" }        
  end

end
