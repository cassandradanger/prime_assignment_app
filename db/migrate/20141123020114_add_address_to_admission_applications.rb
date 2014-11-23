class AddAddressToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :address, :string
  end
end
