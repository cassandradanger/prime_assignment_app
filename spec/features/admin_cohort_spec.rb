require "rails_helper"

feature 'A logged in administrator' do

  before :each do
    @admin = FactoryGirl.create(:admin)
    visit new_admin_session_path
    fill_in 'admin_email', with: @admin.email
    fill_in 'admin_password', with: @admin.password
    click_button 'Login'
  end

  scenario 'vists the cohort index page successfully' do
    visit cohorts_path
    within(".wrapper-content") do
      page.has_content?('Cohorts')
    end
  end

  scenario 'a new cohort fails without earnest code' do
    visit new_cohort_path
    fill_in 'cohort_name', with: 'test'
    fill_in 'cohort_prework_start', with: 1.day.from_now
    fill_in 'cohort_classroom_start', with: 1.day.from_now
    fill_in 'cohort_graduation', with: 1.day.from_now
    fill_in 'cohort_applications_open', with: 1.day.from_now
    fill_in 'cohort_applications_close', with: 1.day.from_now
    fill_in 'cohort_target_size', with: '20'
    click_button 'Save'
    page.has_content?("can't be blank")
  end

  scenario 'a new cohort succeeds' do
    visit new_cohort_path
    fill_in 'cohort_name', with: 'test'
    fill_in 'cohort_prework_start', with: 1.day.from_now
    fill_in 'cohort_classroom_start', with: 1.day.from_now
    fill_in 'cohort_graduation', with: 1.day.from_now
    fill_in 'cohort_applications_open', with: 1.day.from_now
    fill_in 'cohort_applications_close', with: 1.day.from_now
    fill_in 'cohort_target_size', with: '20'
    fill_in 'cohort_earnest_application_code', with: 'test_code'
    click_button 'Save'
    within('.page-heading') do
      page.has_content?("Cohort :: test")
    end
  end
end