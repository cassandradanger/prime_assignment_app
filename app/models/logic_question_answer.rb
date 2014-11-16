class LogicQuestionAnswer < ActiveRecord::Base
	belongs_to :admission_application
	belongs_to :logic_question

	validates_presence_of :answer
end
