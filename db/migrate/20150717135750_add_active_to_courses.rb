class AddActiveToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :active, :boolean, default: true
    add_column :logic_questions, :active, :boolean, default: true
    add_column :profile_questions, :active, :boolean, default: true
  end
end
