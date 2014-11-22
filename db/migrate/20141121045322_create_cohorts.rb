class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.date :prework_start
      t.date :classroom_start
      t.date :graduation
      t.date :applications_open
      t.date :applications_close

      t.timestamps
    end
  end
end
