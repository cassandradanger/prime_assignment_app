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
    subject { app }
    its(:application_status) { should == 'not_started' }

    it 'should have a valid factory' do
      FactoryGirl.create(:new_admission_application).should be_valid
    end

    it 'should have a valid complete factory' do
      FactoryGirl.build(:complete_admission_application).should be_valid
    end


    context 'without any information' do
      let(:app) { FactoryGirl.create(:new_admission_application) }
      subject { app }

      it 'should be invalid' do
        app.application_step = 'submit'
        expect(app).to_not be_valid
      end

      it 'should set the status to started when the step is populated and status = not_stated' do
        app.application_step = 'logic'
        app.application_status = 'not_started'
        expect(app).to be_valid
        expect(app.active?).to equal(false)
        expect {app.save}.to change {app.application_status}.from('not_started').to('started')
      end

    end
  end

  describe 'with complete information' do

    let(:app) {FactoryGirl.create(:complete_admission_application)}
    subject { app }

    its(:application_status) {should == 'not_started'}

    it 'should be valid' do
      app.application_step = 'submit'
      expect(app).to be_valid
    end

    it 'should be marked as completed when submitted' do
      app.application_step = 'submit'
      expect {app.save}.to change {app.application_status}.from('not_started').to('completed')
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
      FactoryGirl.create(:profile_question)
      app.application_step = 'submit'
      expect(app).to_not be_valid
    end
  end

end