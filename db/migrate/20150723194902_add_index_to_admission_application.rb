class AddIndexToAdmissionApplication < ActiveRecord::Migration
  def change
    add_index :admission_applications, :application_status
    add_index :admission_applications, :assigned_cohort_id
  end
end
