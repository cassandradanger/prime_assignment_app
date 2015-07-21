require 'rails_helper'
require 'rspec/its'

describe AdmissionApplication do

  before do
    # Prevent actually calling the Mailchimp API
    RSpec.configure do |config|
      config.mock_with :rspec do |mocks|
        mocks.verify_partial_doubles = false
        mocks.syntax = [:should, :expect]
      end
    end
    #allow(Gibbon::API).to receive_message_chain(:lists, :subscribe).and_return(nil)
    Gibbon::API.stub_chain(:lists, :subscribe).and_return(nil)
  end

  it { should respond_to(:application_status_name) }

  it { should respond_to(:interview_score_name) }

  it { AdmissionApplication.should respond_to(:interview_score_options) }

  it { AdmissionApplication.should respond_to(:application_status_options) }

  it { AdmissionApplication.should respond_to(:application_status_filter_scope_options) }

  it { AdmissionApplication.should respond_to(:comment_sub_type_options) }

  it { AdmissionApplication.new().should respond_to(:days_since_status_update) }

  it 'should send an email when created' do
    mailcount = ActionMailer::Base.deliveries.count
    @admission_application = FactoryGirl.create(:admission_application)
    ActionMailer::Base.deliveries.count.should == mailcount+1
  end

  # context 'when new' do
  #   let(:app) {AdmissionApplication.new}
  #   it {app.application_status.should == 'not_started'}
  # end

  context 'when new' do
    let(:app) { AdmissionApplication.new }
    it 'should have a current state of not_started' do
      expect(app.not_started?).to eq(true)
    end

    it 'should have an instance variable of just_started not equal true' do
      expect(app.just_started).to_not eq(true)
    end

    it 'should have an instance variable of just_completed not equal true' do
      expect(app.just_completed).to_not eq(true)
    end
  end
  context 'without any information' do
    let(:app) { FactoryGirl.create(:new_admission_application) }
    subject { app }

    it 'should have a valid factory' do
      expect(app).to be_valid
    end

    it 'should have an assigned cohort' do
      expect(app.cohorts.count).to equal(1)
    end

    it 'should be invalid' do
      app.application_step = 'submit'
      expect(app).to_not be_valid
    end

    it 'should set the status to started when the step is populated and status = not_stated' do
      app.application_step = 'logic'
      app.application_status = 'not_started'
      expect(app).to be_valid
      expect(app.active?).to equal(false)
      expect { app.save }.to change { app.application_status }.from('not_started').to('started')
    end

    it 'should have just_started == true when started' do
      app.application_step = 'logic'
      app.application_status = 'not_started'
      expect { app.save }.to change { app.just_started }.from(nil).to(true)
    end

  end


  describe 'with complete information' do

    let(:app) { FactoryGirl.create(:complete_admission_application) }
    subject { app }

    it 'should have a valid complete factory' do
      expect(app).to be_valid
    end

    it 'should have a current_state == started' do
      expect(app.started?).to eq(true)
    end

    it 'should be valid' do
      app.application_step = 'submit'
      expect(app).to be_valid
    end

    it 'should be marked as completed when submitted' do
      app.application_step = 'submit'
      expect { app.save }.to change { app.application_status }.from('started').to('completed')
    end

    it 'should have just_completed == true when completed' do
      app.application_step = 'submit'
      expect { app.save }.to change { app.just_completed }.from(nil).to(true)
    end

    it 'should record the completed_at time when submitted' do
      app.application_step = 'submit'
      app.save
      expect(app.completed_at).to_not be_nil
    end

    it 'should have an application_status_name of Complete' do
      app.application_status = 'completed'
      expect(app.application_status_name).to eq('Completed')
    end

    it 'with new profile question should be invalid' do
      app.profile_question_answers.each do |question|
        question.answer = ''
      end
      app.application_step = 'submit'
      expect(app).to_not be_valid
    end

    it 'should change the status to Complete when using the workflow to change status' do
      expect { app.complete! }.to change { app.current_state }.from('started').to('completed')
    end

    it 'should provide Today as days since last update' do
      app.complete!
      expect(app.days_since_status_update).to eq('Today')
    end

    it 'should create an audit record when using the workflow' do
      current_count = app.audits.count
      app.complete!
      expect(app.audits.count).to eq(current_count + 1)
    end

    it 'should create an audit record when saving with changes' do
      current_count = app.audits.count
      app.first_name = "#{app.first_name} test"
      app.save
      expect(app.audits.count).to eq(current_count + 1)
    end

    it 'should not create an audit record when saving without changes' do
      current_count = app.audits.count
      app.save
      expect(app.audits.count).to eq(current_count)
    end

  end

end