class LogicQuestionAnswer < ActiveRecord::Base
	belongs_to :admission_application, :inverse_of => :logic_question_answers
	belongs_to :logic_question
	validates_presence_of :admission_application, :logic_question	
	validates_presence_of :answer, :allow_blank=>false, :allow_nil=>false, :on=>:update, :if=>:admission_application_active?

	def admission_application_active?
		self.admission_application.active?
	end

end
