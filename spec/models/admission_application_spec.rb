require "rails_helper"

describe AdmissionApplication do

	describe 'without any information' do
		before do
			@admission_application = AdmissionApplication.new
		end

		it 'should be invalid' do
			@admission_application.application_step = "active"
			@admission_application.application_status = "complete"
			@admission_application.should_not be_valid
		end
	end

	describe 'with complete information' do
		before do
			@admission_application = FactoryGirl.create(:admission_application)
		end

		it 'should be valid' do
			@admission_application.application_step = "active"
			@admission_application.application_status = "complete"
			@admission_application.should be_valid
		end

		it 'should be invalid if a new profile question is added' do
			FactoryGirl.create(:profile_question)
			@admission_application.application_step = "active"
			@admission_application.application_status = "complete"
			@admission_application.should_not be_valid
		end

	end

end