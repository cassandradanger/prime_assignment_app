require "rails_helper"

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
end