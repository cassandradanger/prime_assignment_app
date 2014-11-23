FactoryGirl.define do
  factory :profile_question_answer do
    answer "My answer to the profile question"
	score 5
	profile_question
  end

end
