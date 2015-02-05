class AddAssignedCohortIdToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :assigned_cohort_id, :integer, index: true
  end
end
