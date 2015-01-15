require "rails_helper"

feature 'A logged in administrator' do

  before :each do
    @admin = FactoryGirl.create(:admin)
    visit new_admin_session_path
    fill_in 'admin_email', with: @admin.email
    fill_in 'admin_password', with: @admin.password
    click_button 'Log in'
  end

  scenario 'vists the admin root page successfully' do
    visit '/admin/'
    within("#content") do
      page.has_content?('New Applications')
    end
  end

  scenario 'vists the dashboard page successfully' do
    visit dashboard_path
    within("#content") do
      page.has_content?('New Application')
    end
  end

  scenario 'vists the admission application index page successfully' do
    visit admission_applications_path
    within("#content") do
      page.has_content?('Listing Applications')
    end
  end

  scenario 'vists the cohort index page successfully' do
    visit cohorts_path
    within("#content") do
      page.has_content?('Cohorts')
    end
  end

  scenario 'vists the logic questions index page successfully' do
    visit logic_questions_path
    within("#content") do
      page.has_content?('Logic Logic Question')
    end
  end
  scenario 'vists the profile questions index page successfully' do
    visit profile_questions_path
    within("#content") do
      page.has_content?('Profile Questions')
    end
  end

end