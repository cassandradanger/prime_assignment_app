require "rails_helper"

feature 'A logged in administrator' do

  before :each do
    @admin = FactoryGirl.create(:admin)
    visit new_admin_session_path
    fill_in 'admin_email', with: @admin.email
    fill_in 'admin_password', with: @admin.password
    click_button 'Login'
  end

  scenario 'vists the employees index page successfully' do
    visit admins_path
    within(".wrapper-content") do
      page.has_content?('Employees')
    end
  end
end