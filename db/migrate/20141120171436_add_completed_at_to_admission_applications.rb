class AddCompletedAtToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :completed_at, :datetime
  end
end
