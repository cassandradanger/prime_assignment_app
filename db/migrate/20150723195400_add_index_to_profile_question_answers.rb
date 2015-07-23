class AddIndexToProfileQuestionAnswers < ActiveRecord::Migration
  def change
    add_index :profile_question_answers, :admission_application_id
  end
end
