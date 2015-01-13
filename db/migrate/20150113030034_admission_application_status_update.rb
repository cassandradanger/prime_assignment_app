class AdmissionApplicationStatusUpdate < ActiveRecord::Migration
  def data
     apps = AdmissionApplication.where("application_status IS NULL AND application_step IS NOT NULL")
     apps.each do |a|
       a.application_status = "started"
       a.save
     end

     apps = AdmissionApplication.where("application_status IS NULL AND application_step IS NULL")
     apps.each do |a|
       a.application_status = "not_started"
       a.save
     end

     apps = AdmissionApplication.where("application_status = 'complete' AND application_step = 'submit'")
     apps.each do |a|
       a.application_step = "thanks"
       a.save
     end
  end
end
