class AddCourseIdToCohort < ActiveRecord::Migration
  def change
    add_reference :cohorts, :course, index: true
    add_reference :logic_questions, :course, index: true
    add_reference :profile_questions, :course, index: true
    add_reference :admission_applications, :course, index: true
  end
end
