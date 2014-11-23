require "rails_helper"

feature 'A logged in visitor' do

	before :each do
		@cohort = FactoryGirl.create(:cohort)
		@user = FactoryGirl.create(:user)
		visit new_user_session_path
		fill_in 'user_email', with: @user.email
		fill_in 'user_password', with: @user.password
		click_button 'Log in'	    
	end

	scenario 'vists the start step page successfully' do
		visit '/apply/start'
		page.has_content?('Start')
	end

	scenario 'vists the general step page successfully' do
		visit '/apply/general'
		page.has_content?('General')
	end

	scenario 'vists the profile step page successfully' do
		visit '/apply/personal'
		page.has_content?('Personal')
	end

	scenario 'vists the logic step page successfully' do
		visit '/apply/logic'
		page.has_content?('Logic')
	end

	scenario 'vists the submit step page successfully' do
		visit '/apply/submit'
		page.has_content?('Submit')
	end

	feature 'without a completed profile' do

		scenario 'tries to submit their application and is displayed an error' do
			visit '/apply/submit'
			click_button 'Submit'
	    current_path.should == '/apply/submit'			
	    page.has_content?('error')
		end

		scenario 'tries to submit the incomplete general page and recieves an error' do
			visit '/apply/general'
			click_button 'Save Your Application and Continue'
	    current_path.should == '/apply/general'			
	    page.has_content?('error')
		end

	end

	feature 'with a completed profile' do

		before :each do
			FactoryGirl.create(:admission_application, user: @user)
		end

		scenario 'visits the submit page and completes their application' do
			visit '/apply/submit'
			click_button 'Submit'
	    	page.has_no_content?('error')			
	    	current_path.should == '/apply/start'			
		end

		scenario 'visits the submit page and completes application after a new logic question was added and receives an error' do
			FactoryGirl.create(:logic_question)
			visit '/apply/submit'
			click_button 'Submit'
	    	page.has_content?('error')			
	    	current_path.should == '/apply/submit'			
		end

		scenario 'visits the submit page and completes application after a new profile question was added and receives an error' do
			FactoryGirl.create(:profile_question)
			visit '/apply/submit'
			click_button 'Submit'
	    	page.has_content?('error')			
	    	current_path.should == '/apply/submit'			
		end

	end

end