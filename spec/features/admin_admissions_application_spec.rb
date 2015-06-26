require "rails_helper"

feature 'An inactive administrator' do
  before :each do
    @admin = FactoryGirl.create(:inactive_admin)
  end

  scenario 'tries to login and fails' do
    visit new_admin_session_path
    fill_in 'admin_email', with: @admin.email
    fill_in 'admin_password', with: @admin.password
    click_button 'Login'
    page.has_content?('Your account is inactive')
  end
end

feature 'A logged in administrator' do

  before :each do
    @admin = FactoryGirl.create(:admin)
    visit new_admin_session_path
    fill_in 'admin_email', with: @admin.email
    fill_in 'admin_password', with: @admin.password
    click_button 'Login'
  end

  scenario 'vists the admin root page successfully' do
    visit '/admin/'
    within(".wrapper-content") do
      page.has_content?('New Applications')
    end
    within('.navbar-right') do
      page.has_content?(@admin.email)

    end
    within('#side-menu') do
      page.has_css?('fa fa-line-chart')
    end
  end

  scenario 'vists the dashboard page successfully' do
    visit dashboard_path
    current_path.should == dashboard_path
    within(".wrapper-content") do
      page.has_content?('New Application')
    end
  end

  scenario 'vists the admission application index page successfully' do
    visit admission_applications_path
    within(".wrapper-content") do
      page.has_content?('Listing Applications')
    end
  end

  scenario 'vists the cohort index page successfully' do
    visit cohorts_path
    within(".wrapper-content") do
      page.has_content?('Cohorts')
    end
  end

  scenario 'vists the logic questions index page successfully' do
    visit logic_questions_path
    within(".wrapper-content") do
      page.has_content?('Logic Logic Question')
    end
  end
  scenario 'vists the profile questions index page successfully' do
    visit profile_questions_path
    within(".wrapper-content") do
      page.has_content?('Profile Questions')
    end
  end

  feature 'views admission application screen' do

    before :each do
      @admission_application = FactoryGirl.create(:complete_admission_application)
    end

    scenario 'verifies content' do
      visit admission_application_path(@admission_application)
      page.has_content?(@admission_application.first_name)
      page.has_content?(@admission_application.last_name)
      page.has_content?(@admission_application.email)
    end

    scenario 'verifies workflow content and actions' do
      @admission_application.complete!

      visit admission_application_path(@admission_application)

      next_state = AdmissionApplication.workflow_state_name(@admission_application.current_state.events[:need_schedule][0].transitions_to)
      current_state = AdmissionApplication.workflow_state_name(@admission_application.current_state.to_sym)

      within('#workflow-current-state') do
        page.has_content?(current_state)
      end

      within('#workflow-buttons') do
        page.has_content?('Update Status')
        page.has_content?(next_state)
        click_link next_state
      end

      current_path.should == admission_application_path(@admission_application)

      within('#workflow-current-state') do
        page.has_content?(next_state)
      end
    end

    scenario 'tries to add a call note' do
      visit admission_application_path(@admission_application)
      within("#new_comment") do
        fill_in 'comment_content', with: 'This is a test note'
        click_button "Add Call Note"
      end
      current_path.should == admission_application_path(@admission_application)
      page.has_content?("Note created successfully!")
      page.has_content?("This is a test note")
    end

    scenario 'tries to update the technical challenge form' do
      visit admission_application_path(@admission_application)
      select '3', from: 'resume_score_admission_application_resume_score'
      fill_in 'resume_score_admission_application_comments_attributes_0_content', with: 'This is a technical note'
      click_button 'technical_score_submit'
      current_path.should == admission_application_path(@admission_application)
      page.has_content?('Technical (3)')
      page.has_content?('Application updated successfully!')
      page.has_content?('This is a technical note')
    end

    scenario 'tries to update the interview score' do
      visit admission_application_path(@admission_application)
      select '5', from: 'interview_score_admission_application_interview_score'
      click_button 'interview_score_submit'
      current_path.should == admission_application_path(@admission_application)
      page.has_content?('Interview (5)')
      page.has_content?('Application updated successfully!')
    end
  end

  feature 'admission application edit screen' do

    before :each do
      @admission_application = FactoryGirl.create(:complete_admission_application)
    end

    scenario 'verifies content' do
      visit edit_admission_application_path(@admission_application)
      page.has_content?(@admission_application.first_name)
      page.has_content?(@admission_application.last_name)
    end

    scenario 'tries to update record' do
      visit edit_admission_application_path(@admission_application)
      fill_in 'admission_application_birthdate', with: '05/15/1974'
      select 'Male', from: 'admission_application_gender'
      check 'admission_application_race_hispanic'
      check 'admission_application_race_white'
      fill_in 'admission_application_dependents', with: '5'
      select 'Urban', from: 'admission_application_geography'
      click_button 'Save'
      current_path.should == admission_application_path(@admission_application)
      page.has_content?('Application updated successfully')
    end
  end

end