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

	feature 'starts with new profile' do

		before :each do
			@admission_application = FactoryGirl.create(:new_admission_application, user: @user)
		end

		scenario 'tries to submit their application and is displayed an error' do
			visit '/apply/submit'
			check 'admission_application_payment_plan'
			click_button 'Submit your application'
		    current_path.should == '/apply/submit'			
		    page.has_content?('problem')
		end

		scenario 'tries to submit the incomplete general page and receives an error' do
			visit '/apply/general'
			click_button 'Save Your Application and Continue'
		    current_path.should == '/apply/general'			
		    page.has_content?('problem')
		end

		scenario 'tries to submit a complete general page and navigates to the personal page' do
			visit '/apply/general'
			fill_in 'admission_application_first_name', with: 'FirstName'
			fill_in 'admission_application_last_name', with: 'LastName'
			fill_in 'admission_application_phone', with: '123-123-1233'
			fill_in 'admission_application_address', with: '123 Some St.'
			fill_in 'admission_application_city', with: 'Some City'
			fill_in 'admission_application_state', with: 'MN'
			fill_in 'admission_application_zip_code', with: '90210'
			select 'US Citizen', from: 'admission_application_legal_status'
			select 'High School', from: 'admission_application_education'
			select 'Employed Full-time', from: 'admission_application_employment_status'
			select 'Find work as a software engineer', from: 'admission_application_goal'
			fill_in 'admission_application_income', with: '45000'
			select 'Search Engine', from: 'admission_application_referral_source'
	#		check '#admission_application_cohort_ids_1'
			click_button 'Save Your Application and Continue'
			current_path.should == '/apply/personal'
		end

		scenario 'reviews the application expecting a profile error' do
			visit '/apply/submit'
			page.has_content?("Profile questions must all be answered")
		end

		scenario 'tries to submit a complete personal page and navigates to the logic page' do
			visit '/apply/personal'
			all("textarea").each { |t| t.text("Answer to the question.") }
			click_button 'Save Your Application and Continue'
			current_path.should == '/apply/logic'
		end

	end

	feature 'with a complete profile' do

		before :each do
			@admission_application = FactoryGirl.create(:complete_admission_application, user: @user)
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