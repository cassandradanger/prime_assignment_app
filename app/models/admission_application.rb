class AdmissionApplication < ActiveRecord::Base

	before_validation :populate_questions, on: :update
	after_save :populate_questions, on: :create

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

	private

		# add questions upon creation of a new application
		def populate_questions
			LogicQuestion.transaction do 
				LogicQuestion.current.each do |question|
					logic_question_answers.find_or_create_by!(logic_question_id: question.id)
				end
			end
			ProfileQuestion.transaction do
				ProfileQuestion.current.each do |question|
					profile_question_answers.find_or_create_by!(profile_question_id: question.id)
					ProfileQuestion.connection.commit_db_transaction
				end
			end
		end

end
