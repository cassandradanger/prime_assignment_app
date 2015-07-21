require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it 'should have a valid factory' do
    FactoryGirl.build(:comment).should be_valid
  end

  it { should validate_presence_of(:admin) }
end
