class AddStatusToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :status, :string, default: 'Active'
  end
end
