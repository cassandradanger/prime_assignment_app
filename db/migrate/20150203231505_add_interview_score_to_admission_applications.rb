class AddInterviewScoreToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :interview_score, :integer, default: 0
  end


end
