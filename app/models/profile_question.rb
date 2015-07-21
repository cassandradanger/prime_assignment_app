class ProfileQuestion < ActiveRecord::Base

  default_scope { order(:position) }
  scope :current, -> { where(published: true).where(active: true) }
  scope :active, -> { where(active: true) }

  has_many :profile_question_answers
  belongs_to :course

end
