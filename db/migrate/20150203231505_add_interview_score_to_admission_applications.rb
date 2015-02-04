class AddInterviewScoreToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :interview_score, :integer, default: 0
  end

  def data
    apps = AdmissionApplication.where(application_status: "interview_passed")
    apps.each do |app|
      app.interview_score = 3
      app.save
    end
  end
end
