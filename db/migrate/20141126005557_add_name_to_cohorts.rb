class AddNameToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :name, :string
  end
end
