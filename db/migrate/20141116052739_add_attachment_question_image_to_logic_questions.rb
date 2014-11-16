class AddAttachmentQuestionImageToLogicQuestions < ActiveRecord::Migration
  def self.up
    change_table :logic_questions do |t|
      t.attachment :question_image
    end
  end

  def self.down
    remove_attachment :logic_questions, :question_image
  end
end
