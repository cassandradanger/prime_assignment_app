class AddNameToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :first_name, :string, after: :id
    add_column :admins, :last_name, :string, after: :first_name
  end
end
