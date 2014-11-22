class LogicQuestionAnswer < ActiveRecord::Base
	belongs_to :admission_application
	belongs_to :logic_question
	validates_presence_of :admission_application, :logic_question	
	validates_presence_of :answer, :allow_blank=>false, :allow_nil=>false, :on=>:update
end
