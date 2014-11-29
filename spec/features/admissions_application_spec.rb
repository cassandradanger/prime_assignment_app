require "rails_helper"

feature 'A logged in visitor' do

	before :each do
		@cohort = FactoryGirl.create(:cohort)
		@user = FactoryGirl.create(:user)
		visit new_user_session_path
		fill_in 'user_login_email', with: @user.email
		fill_in 'user_login_password', with: @user.password
		click_button 'Continue Your Application'	    
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
			check 'admission_application_payment_plan'
			click_button 'Submit your application'
		    current_path.should == '/apply/submit'			
		    page.has_content?('problem')
		end

		scenario 'tries to submit the incomplete general page and recieves an error' do
			visit '/apply/general'
			click_button 'Save Your Application and Continue'
		    current_path.should == '/apply/general'			
		    page.has_content?('problem')
		end

	end

	feature 'with a complete profile' do

		before :each do
			@admission_application = FactoryGirl.create(:admission_application, user: @user)
		end

		scenario 'visits the submit page and submits their application without accepting the payment plan' do
			visit '/apply/submit'
			click_button 'Submit your application'
	    	page.has_content?('problem')			
	    	current_path.should == '/apply/submit'			
		end

		scenario 'visits the submit page and submits their application, accepting the payment plan' do
			visit '/apply/submit'
			check 'admission_application_payment_plan'
			click_button 'Submit your application'
	    	page.has_no_content?('problem')			
	    	current_path.should == '/apply/thanks'			
		end


		scenario 'visits the submit page and submits application after a new logic question was added and receives an error' do
			FactoryGirl.create(:logic_question)
			visit '/apply/submit'
			check 'admission_application_payment_plan'
			click_button 'Submit your application'
	    	page.has_content?('problem')			
	    	current_path.should == '/apply/submit'			
		end

		scenario 'visits the submit page and submits application after a new profile question was added and receives an error' do
			FactoryGirl.create(:profile_question)
			visit '/apply/submit'
			check 'admission_application_payment_plan'
			click_button 'Submit your application'
	    	page.has_content?('problem')			
	    	current_path.should == '/apply/submit'			
		end

		feature 'that has submitted their profile' do

			before :each do
				visit '/apply/submit'
				check "admission_application_payment_plan"
				click_button 'Submit your application'
			end

			scenario 'is redirected to the thanks page when visiting any other application page' do
				visit '/apply/start'
		    	current_path.should == '/apply/thanks'
				visit '/apply/general'
		    	current_path.should == '/apply/thanks'
				visit '/apply/personal'
		    	current_path.should == '/apply/thanks'
				visit '/apply/logic'
		    	current_path.should == '/apply/thanks'
				visit '/apply/technical'
		    	current_path.should == '/apply/thanks'
				visit '/apply/submit'
		    	current_path.should == '/apply/thanks'
			end

		end

	end

end