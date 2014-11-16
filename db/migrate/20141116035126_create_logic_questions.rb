class CreateLogicQuestions < ActiveRecord::Migration
  def change
    create_table :logic_questions do |t|
      t.text :question
      t.string :solution
      t.string :status

      t.timestamps
    end
  end
end
