class AddIndexToAdmissionApplicationCohorts < ActiveRecord::Migration
  def change
    add_index :admission_applications_cohorts, :cohort_id
  end
end
