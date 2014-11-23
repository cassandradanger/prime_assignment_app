FactoryGirl.define do

  factory :admission_application do
    first_name "John"
	last_name "Doe"
	middle_name "Theodore"
	date_of_birth "1978-07-19"
	city "Minneapolis"
	state "Minnesota"
	zip_code "55412"
	legal_status "Citizen"
	employment_status "Employed"
	linkedin_account "http://linkedin.com/profile/view?id=123456"
	twitter_account "http://twitter.com/goprimeacademy"
	github_account "https://github.com/primeacademy"
	personal_link "http://primeacademy.io"
	resume_link "http://primeacademy.io"
	referral_source "Search engine"
	user
	after(:create) do |application| 
		application.cohorts = [create(:cohort)]
		application.logic_question_answers = create_list(:logic_question_answer, 10, admission_application: application)
		application.profile_question_answers = create_list(:profile_question_answer, 10, admission_application: application)		
	end
  end

end