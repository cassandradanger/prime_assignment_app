class UpdateApplicationStatus < ActiveRecord::Migration
  def change
    apps = AdmissionApplication.where("application_status = 'not_started' AND application_step IS NOT NULL")
    apps.each do |a|
      a.application_status = "started"
      a.save
    end
  end
end
