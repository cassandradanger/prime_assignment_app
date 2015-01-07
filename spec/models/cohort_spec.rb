require "rails_helper"

describe Cohort do
  describe 'when new' do

    it 'should have a valid factory' do
      FactoryGirl.build(:cohort).should be_valid
    end

  end

end