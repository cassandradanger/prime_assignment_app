class AddIndexToLogicQuestionAnswers < ActiveRecord::Migration
  def change
    add_index :logic_question_answers, :admission_application_id
  end
end
