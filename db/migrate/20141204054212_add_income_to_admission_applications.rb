class AddIncomeToAdmissionApplications < ActiveRecord::Migration
  def change
    add_column :admission_applications, :income, :integer
  end
end
