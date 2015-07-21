FactoryGirl.define do
  factory :course do
    sequence(:code) { |n| "#{n}CODE" }
    name "Course Name"
    description "Course Description"

    transient do
      logic_questions_count 5
      profile_questions_count 5
    end

    factory :course_with_questions do
      after(:create) do |course, evaluator|
        course.logic_questions = create_list(:logic_question, evaluator.logic_questions_count, course: course)
        course.profile_questions = create_list(:profile_question, evaluator.profile_questions_count, course: course)
      end
    end
  end

end
