FactoryGirl.define do

  factory :admission_application do
    first_name "John"
    last_name "Doe"
    middle_name "Theodore"
    date_of_birth "1978-07-19"
    phone "123-456-7890"
    address "123 Fake St."
    city "Minneapolis"
    state "Minnesota"
    zip_code "55412"
    legal_status "Citizen"
    employment_status "Employed"
    linkedin_account "http://linkedin.com/profile/view?id=123456"
    twitter_account "http://twitter.com/goprimeacademy"
    github_account "https://github.com/primeacademy"
    resume_link "http://primeacademy.io"
    referral_source "Search engine"
    payment_plan "1"
    education "High School"
    goal "Work as a software engineer"
    payment_option "Prepay"

    user
    after(:create) do |application|
      application.cohorts = [create(:cohort)]
      application.logic_question_answers = create_list(:logic_question_answer, 10, admission_application: application)
      application.profile_question_answers = create_list(:profile_question_answer, 10, admission_application: application)
    end
  end

end
