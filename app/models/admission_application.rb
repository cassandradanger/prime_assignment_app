class AdmissionApplication < ActiveRecord::Base
	belongs_to :user
	has_many :logic_question_answers
	accepts_nested_attributes_for :logic_question_answers
	validates :last_name, :presence => true, :if => :active_or_general?
	validates_associated :logic_question_answers, :if => :active?, :message=>"are incomplete."

	def active?
		application_step == 'active'
	end

	def active_or_logic?
		application_step == 'logic' || active?
	end

	def active_or_general?
		application_step == 'general' || active?
	end

	def active_or_personal?
		application_step == 'personal' || active?
	end

end
