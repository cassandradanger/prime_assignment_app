class AddApplicationStatusUpdatedAtToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :application_status_updated_at, :timestamp
  end
  def data
    apps = AdmissionApplication.all
    apps.each do |app|
      app.application_status_updated_at = app.updated_at
      app.update_record_without_timestamping
    end
  end
end
