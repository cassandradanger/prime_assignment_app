class AddEarnestApplicationCodeToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :earnest_application_code, :string
  end
end
