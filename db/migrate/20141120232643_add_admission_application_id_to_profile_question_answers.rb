class AddAdmissionApplicationIdToProfileQuestionAnswers < ActiveRecord::Migration
  def change
    add_column :profile_question_answers, :admission_application_id, :integer
  end
end
