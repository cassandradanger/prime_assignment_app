class ProfileQuestion < ActiveRecord::Base
	scope :current, -> { where(published: true) }
	has_many :profile_question_answers
end
