FactoryGirl.define do
  factory :cohort do
    prework_start Date.today+12.weeks
		classroom_start Date.today+18.weeks
		graduation Date.today+30.weeks
		applications_open Date.today-1.day
		applications_close Date.today+6.weeks
		target_size 20
    earnest_application_code 'earnest_app_code'
  end
end
