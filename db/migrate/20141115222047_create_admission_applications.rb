class CreateAdmissionApplications < ActiveRecord::Migration
  def change
    create_table :admission_applications do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :date_of_birth
      t.string :email
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :legal_status
      t.string :education
      t.string :employment_status
      t.string :linkedin_account
      t.string :twitter_account
      t.string :github_account
      t.string :website_link
      t.string :personal_link
      t.string :resume_link
      t.string :referral_source
      t.text :question_reason_for_applying
      t.text :question_why_prime
      t.text :question_intensity
      t.text :question_technology_background
      t.text :question_self_differentiation
      t.text :question_three_month_prediction
      t.text :question_three_year_aspiration
      t.text :question_actions_toward_goals
      t.string :application_status
      t.string :application_step
      t.integer :user_id

      t.timestamps
    end
  end
end
