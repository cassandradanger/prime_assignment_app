class AddPublishedToLogicQuestions < ActiveRecord::Migration
  def change
    add_column :logic_questions, :published, :boolean
    remove_column :logic_questions, :status
  end
end
