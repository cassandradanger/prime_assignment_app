FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@primeacademy.io" }
    password "password"
    password_confirmation { "password" }
    status "Active"

    factory :inactive_admin do
      status "Inactive"
    end
  end

end
