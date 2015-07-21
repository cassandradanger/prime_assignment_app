require "rails_helper"

describe Cohort do

  it { should respond_to(:label) }
  it { should respond_to(:has_applications?) }
  it { should respond_to(:active?) }
  it { should respond_to(:status) }
  it { should respond_to(:accepted_application_count) }
  it { should respond_to(:confirmed_application_count) }
  it { should respond_to(:accepted_application_pct) }
  it { should respond_to(:confirmed_application_pct) }
  it { should respond_to(:accepted_applicants_by_age_group) }

  describe 'when new' do
    it 'should have a valid factory' do
      create(:cohort).should be_valid
    end
  end

  describe 'when saving' do
    before :each do
      @cohort = create(:cohort)
    end
    it 'should require a target size' do
      @cohort.target_size = nil
      expect(@cohort).to_not be_valid
    end
    it 'should require an earnest application code' do
      @cohort.earnest_application_code = nil
      expect(@cohort).to_not be_valid
    end
    it 'should require a course' do
      @cohort.course = nil
      expect(@cohort).to_not be_valid
    end
  end


end