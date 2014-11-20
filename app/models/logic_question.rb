class LogicQuestion < ActiveRecord::Base
	scope :current, -> { where(:status => "active") }
	has_attached_file :question_image
	validates_attachment_content_type :question_image, :content_type => /\Aimage\/.*\Z/
end
