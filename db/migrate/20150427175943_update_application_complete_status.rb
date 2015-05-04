class UpdateApplicationCompleteStatus < ActiveRecord::Migration
  def data
    apps = AdmissionApplication.where(application_status: "complete")
    apps.each do |app|
      dt = app.application_status_updated_at
      app.application_status = "completed"
      app.save
      app.application_status_updated_at = dt
      app.save
    end
  end
end
