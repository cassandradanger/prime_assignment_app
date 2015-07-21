require 'rails_helper'
require 'rspec/its'

RSpec.describe Course, type: :model do
  it { should respond_to(:label) }

  it 'should have a valid factory' do
    build(:course).should be_valid
  end

  it 'should have a valid factoy with questions' do
    course = build(:course_with_questions)
    course.should be_valid
  end

  it 'should have have questions' do
    course = create(:course_with_questions)
    expect(course.logic_questions.count).to be > 0
    expect(course.profile_questions.count).to be > 0
  end

  it 'should force code to uppercase' do
    course = Course.new
    course.code = 'testcode'
    expect(course.code).to eq('TESTCODE')
  end

end
