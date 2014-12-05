class ProfileQuestionAnswer < ActiveRecord::Base
	belongs_to :admission_application, :inverse_of => :profile_question_answers
	belongs_to :profile_question
	validates_presence_of :admission_application, :profile_question
	validates_presence_of :answer, :allow_blank=>false, :allow_nil=>false, :on=>:update, :if=>:admission_application_active?

	def admission_application_active?
		self.admission_application.active?
	end

end
