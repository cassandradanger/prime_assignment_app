class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.string :sub_type
      t.references :admin, index: true
      t.references :notable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
