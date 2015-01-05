class AddResumeNotesToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :resume_notes, :text
  end
end
