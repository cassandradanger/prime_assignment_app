class AdmissionApplication < ActiveRecord::Base

	after_create :populate_questions, on: :create
	before_validation :populate_questions_on_submit

	belongs_to :user

	has_and_belongs_to_many :cohorts
	validates_presence_of :cohorts, :if => :active_or_general?

	has_many :logic_question_answers, dependent: :destroy
	accepts_nested_attributes_for :logic_question_answers
	validates_associated :logic_question_answers, :if => :active?, :message=>"must all be answered."
	
	has_many :profile_question_answers, dependent: :destroy
	accepts_nested_attributes_for :profile_question_answers	
	validates_associated :profile_question_answers, :if => :active?, :message=>"must all be answered."
	
	validates :last_name, :presence => true, :if => :active_or_general?	

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

	def populate_questions_on_submit
		populate_questions if active?
	end

	# add questions upon creation of a new application
	def populate_questions
		LogicQuestion.current.each do |question|
			logic_question_answers.find_or_create_by!(logic_question_id: question.id)
		end
		ProfileQuestion.current.each do |question|
			profile_question_answers.find_or_create_by!(profile_question_id: question.id)
		end
	end

end
