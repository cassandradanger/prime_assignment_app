class RemovePersonalLinkFromAdmissionApplications < ActiveRecord::Migration
  def change
    remove_column :admission_applications, :personal_link, :string
  end
end
