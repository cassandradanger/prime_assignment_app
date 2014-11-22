class CreateProfileQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :profile_question_answers do |t|
      t.text :answer
      t.integer :score

      t.timestamps
    end
  end
end
