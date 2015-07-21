FactoryGirl.define do

  factory :admission_application do
    application_status "not_started"
    course
    user

    # logic_question_count and profile_question_count is declared as a transient
    # attribute and available in attributes on the factory, as well as the callback
    # via the evaluator
    transient do
      logic_questions_count 5
      profile_questions_count 5
    end

    factory :new_admission_application do
      after(:create) do |application, evaluator|
        application.cohorts = [create(:cohort, course: application.course)]
        application.logic_question_answers = create_list(:logic_question_answer, evaluator.logic_questions_count, admission_application: application, answer: nil)
        application.profile_question_answers = create_list(:profile_question_answer, evaluator.profile_questions_count, admission_application: application, answer: nil)
      end
    end

    factory :complete_admission_application do
      first_name "First"
      last_name "Last"
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

      after(:create) do |application, evaluator|
        application.start!
        application.cohorts = [create(:cohort, course: application.course)]
        application.logic_question_answers = create_list(:logic_question_answer, evaluator.logic_questions_count, admission_application: application)
        application.profile_question_answers = create_list(:profile_question_answer, evaluator.profile_questions_count, admission_application: application)
      end
    end
  end
end
