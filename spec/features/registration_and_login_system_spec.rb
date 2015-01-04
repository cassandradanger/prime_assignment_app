require "rails_helper"

feature 'A visitor who is not logged in' do

	feature 'clicks on apply' do
  
	  before :each do
	    @user = FactoryGirl.create(:user)
	    visit '/apply'
	  end

	  scenario 'and is redirected to login if not logged in' do
	  	current_path.should == new_user_session_path
	  end

	  scenario 'then logs in and is redirected to application start' do	  	
	    fill_in 'user_login_email', with: @user.email
	    fill_in 'user_login_password', with: @user.password
	    click_button 'Continue Your Application'
	    current_path.should == '/apply/start'
	  end

	 end

	feature 'follows a link to a step in the application process' do
		
		scenario 'and is redirected to login' do
			visit 'apply/general'
			current_path.should == new_user_session_path
		end

	end

	feature 'requests the administration page for' do
	
		scenario 'logic questions and is redirected to the admin login' do
			visit logic_questions_path
			current_path.should == new_admin_session_path
		end

		scenario 'profile questions and is redirected to the admin login' do
			visit profile_questions_path
			current_path.should == new_admin_session_path
		end

		scenario 'cohorts and is redirected to the admin login' do
			visit cohorts_path
			current_path.should == new_admin_session_path
		end

		scenario 'dashboard and is redirected to the admin login' do
			visit dashboard_path
			current_path.should == new_admin_session_path
		end

		scenario 'dashboard and is redirected to the admin login' do
			visit dashboard_path
			current_path.should == new_admin_session_path
		end

	end

end