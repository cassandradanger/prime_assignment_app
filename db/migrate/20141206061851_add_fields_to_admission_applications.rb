class AddFieldsToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :goal, :string
    add_column :admission_applications, :payment_option, :string
  end
end
