class AddTargetSizeToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :target_size, :integer, default: 20
  end
end
