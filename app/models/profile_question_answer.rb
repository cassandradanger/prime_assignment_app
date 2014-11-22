class ProfileQuestionAnswer < ActiveRecord::Base
	belongs_to :admission_application
	belongs_to :profile_question
	validates_presence_of :admission_application, :profile_question
	validates_presence_of :answer, :allow_blank=>false, :allow_nil=>false, :on=>:update
end
