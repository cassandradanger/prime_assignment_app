require "rails_helper"

describe AdmissionApplication do

	before do
		# Prevent actually calling the Mailchimp API
		RSpec.configure do |config|
		  config.mock_with :rspec do |mocks|
		    mocks.verify_partial_doubles = false
		  end
		end
		Gibbon::API.stub_chain(:lists, :subscribe).and_return(nil)
	end

	describe 'without any information' do
		before do
			@admission_application = AdmissionApplication.new
		end

		it 'should be invalid' do
			@admission_application.application_step = "submit"
			@admission_application.application_status = "complete"
			@admission_application.should_not be_valid
		end
	end

	describe 'with complete information' do
		before do
			@admission_application = FactoryGirl.create(:admission_application)
		end

		it 'should be valid' do
			@admission_application.application_step = "submit"
			@admission_application.application_status = "complete"
			@admission_application.should be_valid
		end

		it 'should be marked as complete when submitted' do
			@admission_application.application_step = "submit"
			@admission_application.save
			@admission_application.application_status.should == "complete"
		end

		it 'should record the completed_at time when submitted' do
			@admission_application.application_step = "submit"
			@admission_application.save
			@admission_application.completed_at.should_not be_nil
		end

		it 'should be invalid if a new profile question is added' do
			FactoryGirl.create(:profile_question)
			@admission_application.application_step = "submit"
			@admission_application.application_status = "complete"
			@admission_application.should_not be_valid
		end
	end

	it 'should send an email when created' do
		mailcount = ActionMailer::Base.deliveries.count
		@admission_application = FactoryGirl.create(:admission_application)
		ActionMailer::Base.deliveries.count.should == mailcount+1
	end
end