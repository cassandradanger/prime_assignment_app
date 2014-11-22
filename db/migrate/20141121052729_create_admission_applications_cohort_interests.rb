class CreateAdmissionApplicationsCohorts < ActiveRecord::Migration
  def change
    create_table :admission_applications_cohorts do |t|
      t.integer :admission_application_id
      t.integer :cohort_id
    end
  end
end
