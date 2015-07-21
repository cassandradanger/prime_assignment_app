feature 'A logged in administrator' do

  before :each do
    @admin = FactoryGirl.create(:admin)
    visit new_admin_session_path
    fill_in 'admin_email', with: @admin.email
    fill_in 'admin_password', with: @admin.password
    click_button 'Login'
  end

  scenario 'vists the course index page successfully' do
    visit courses_path
    within(".wrapper-content") do
      page.has_content?('Course')
    end
  end
end