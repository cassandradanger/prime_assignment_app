class AddPhoneToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :phone, :string
  end
end
