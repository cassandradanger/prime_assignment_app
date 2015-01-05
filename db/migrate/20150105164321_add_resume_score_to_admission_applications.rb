class AddResumeScoreToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :resume_score, :integer
  end
end
