class AdmissionApplication < ActiveRecord::Base

	before_validation :populate_questions_on_submit
	before_save :check_for_completion
	after_create :populate_questions, on: :create
	after_create :send_welcome, :update_subscription
	
	belongs_to :user

	has_and_belongs_to_many :cohorts
	validates_presence_of :cohorts, :if => :active_or_general?

	has_many :logic_question_answers, dependent: :destroy
	accepts_nested_attributes_for :logic_question_answers
	validates_associated :logic_question_answers, :if => :active?, :message=>"must all be answered."
	
	has_many :profile_question_answers, dependent: :destroy
	accepts_nested_attributes_for :profile_question_answers	
	validates_associated :profile_question_answers, :if => :active?, :message=>"must all be answered."
	
	validates :last_name, :first_name, :address, :city, :state, :zip_code, :legal_status, :education, :employment_status, :referral_source, :phone ,:presence => true, :if => :active_or_general?	
	validates_format_of :website_link, :linkedin_account, :with => URI::regexp(%w(http https)), allow_blank: true, message: "is not a valid URL", :if => :active_or_general?
	validates_format_of :resume_link, :with => URI::regexp(%w(http https)), allow_blank: true, message: "is not a valid URL", :if => :active?
	validates_format_of :phone, with: /\d{3}-\d{3}-\d{4}/, message: "is not formatted properly", allow_blank: true

	validates_acceptance_of :payment_plan, :if => :active?, :message=>"must be acknowledged", allow_nil: false

	def name
		"#{self.first_name} #{self.middle_name} #{self.last_name}" unless self.first_name.blank? || self.last_name.blank?
	end

	def full_address
		"#{self.address}\n#{self.city}, #{self.state} #{self.zip_code}" unless self.address.blank? || self.city.blank? || self.state.blank? || self.zip_code.blank?
	end

	def completed?
		application_status == "complete"
	end

	def active?
		application_step == 'submit'
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

	private

	def send_welcome
		AdmissionApplicationMailer.admission_application_welcome(self).deliver
	end

	# Set or update Mailchimp list subscription for applicants
	def update_subscription(options = { app_status: "In Progress", adm_status: "Unevaluated" })
		Gibbon::API.lists.subscribe({:id => ENV['MAILCHIMP_LIST'], :email => {:email => self.user.email}, :merge_vars => {:FNAME => self.first_name, :LNAME => self.last_name, :APP_STATUS => options[:app_status], :ADM_STATUS => options[:adm_status], :GROUPINGS => [{ :name => "I am a:", :groups => ['Applicant']}]}, :double_optin => false, :update_existing => true})		
	end

	# After validation, detect if the application is being submitted and set completed flags
	def check_for_completion
		if active?
			self.application_status = "complete"
			self.completed_at = Time.now
			update_subscription(app_status: "Completed")
		end
	end

end
