class AddPositionToLogicQuestions < ActiveRecord::Migration
  def change
    add_column :logic_questions, :position, :integer
  end
end
