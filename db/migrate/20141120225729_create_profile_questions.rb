class CreateProfileQuestions < ActiveRecord::Migration
  def change
    create_table :profile_questions do |t|
      t.text :question
      t.boolean :published
      t.text :scoring_guideline_1
      t.text :scoring_guideline_2
      t.text :scoring_guideline_3
      t.text :scoring_guideline_4
      t.text :scoring_guideline_5

      t.timestamps
    end
  end
end
