class CreateLogicQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :logic_question_answers do |t|
      t.integer :logic_question_id
      t.integer :admission_application_id
      t.string :answer
      t.text :explanation

      t.timestamps
    end
  end
end
