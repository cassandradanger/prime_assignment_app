FactoryGirl.define do
  factory :comment do
    content "This is a test Note"
    sub_type "call note"
    association :is_commentable, factory: :complete_admission_application

    admin
  end

end
