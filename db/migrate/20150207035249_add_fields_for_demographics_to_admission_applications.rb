class AddFieldsForDemographicsToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :gender, :string
    add_column :admission_applications, :dependents, :integer
    add_column :admission_applications, :geography, :string
    add_column :admission_applications, :birthdate, :date
    add_column :admission_applications, :veteran, :boolean
    add_column :admission_applications, :race_hispanic, :boolean
    add_column :admission_applications, :race_nativeamerican, :boolean
    add_column :admission_applications, :race_asian, :boolean
    add_column :admission_applications, :race_black, :boolean
    add_column :admission_applications, :race_islander, :boolean
    add_column :admission_applications, :race_white, :boolean
    add_column :admission_applications, :race_other, :boolean
  end
end
