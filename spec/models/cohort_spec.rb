require "rails_helper"

describe Cohort do
  describe 'when new' do

    it 'should have a valid factory' do
      FactoryGirl.build(:cohort).should be_valid
    end
  end
  
  describe 'when saving' do
    before do
      @cohort = FactoryGirl.build(:cohort)
    end
    it 'should require a target size' do
      @cohort.target_size = nil
      expect(@cohort).to_not be_valid
    end
    it 'should require an earnest application code' do
      @cohort.earnest_application_code = nil
      expect(@cohort).to_not be_valid
    end
  end

end