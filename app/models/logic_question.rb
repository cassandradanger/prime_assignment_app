class LogicQuestion < ActiveRecord::Base

  default_scope { order(:position) }
  scope :current, -> { where(published: true).where(active: true) }
  scope :active, -> { where(active: true) }

	has_many :logic_question_answers
	belongs_to :course

	has_attached_file :question_image
	validates_attachment_content_type :question_image, :content_type => /\Aimage\/.*\Z/
end
