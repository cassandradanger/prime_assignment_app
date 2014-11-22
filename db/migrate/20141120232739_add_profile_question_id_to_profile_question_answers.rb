class AddProfileQuestionIdToProfileQuestionAnswers < ActiveRecord::Migration
  def change
    add_column :profile_question_answers, :profile_question_id, :integer
  end
end
