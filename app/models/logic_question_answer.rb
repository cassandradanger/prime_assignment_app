class LogicQuestionAnswer < ActiveRecord::Base
	belongs_to :admission_application
	belongs_to :logic_question

	validates_presence_of :answer , :if=>Proc.new { |answer| answer.admission_application.active_or_logic? }

	# private

	# def admission_application_active?
	# 	self.admission_application.active?
	# end
end
