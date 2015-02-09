class AdmissionApplication < ActiveRecord::Base
  include Filterable

  scope :completed, -> { where.not(application_status: "not_started").where.not(application_status: "started") }
  scope :started, -> { where.not(application_status: "not_started") }
  scope :accepted, -> { where(application_status: ["interview_passed", "placed"]) }
  scope :placed, -> { where(application_status: "placed") }
  scope :needs_interview_score, -> { where(application_status: ["scheduled", "interview_passed", "placed"]).where(interview_score: 0) }
  scope :has_referral, -> { started.where.not(referral_source: nil) }
  scope :app_status, -> (status) { (self.is_status_filter_scope?(status)) ? send(status) : where(application_status: status) }
  scope :cohort, lambda { |n| joins(:cohorts).where('cohorts.id = ?', n) }

  # scope :aid_eligible, -> { where(income: 0...23340) }
  scope :aid_ineligible, -> { where("(income > 23341 AND (dependents = 0 OR dependents IS NULL)) OR (income > 31460 AND dependents = 1) OR (income > 39580 AND dependents = 2) OR (income > 47700 AND dependents = 3) OR (income > 55820 AND dependents = 4) OR (income > 63940 AND dependents = 5) OR (income > 72060 AND dependents = 6) OR (income > 80180 AND dependents = 7)") }  
  scope :aid_eligible, -> { where("(income <= 23341 AND (dependents = 0 OR dependents IS NULL)) OR (income <= 31460 AND dependents = 1) OR (income <= 39580 AND dependents = 2) OR (income <= 47700 AND dependents = 3) OR (income <= 55820 AND dependents = 4) OR (income <= 63940 AND dependents = 5) OR (income <= 72060 AND dependents = 6) OR (income <= 80180 AND dependents = 7)") }
  scope :aid_seeking, -> { where(payment_option: "Scholarship") }
  scope :not_aid_seeking, -> { where.not(payment_option: "Scholarship") }

  before_validation :populate_questions_on_submit
  before_save :update_status, :check_assigned_cohort

  after_initialize :init

  after_create :populate_questions, on: :create
  after_create :send_welcome, :update_subscription

  belongs_to :user
  belongs_to :assigned_cohort, class_name: "Cohort"

  has_many :comments, as: :is_commentable

  has_and_belongs_to_many :cohorts, :order => {applications_close: :asc}
  validates_presence_of :cohorts, :if => :active_or_general?

  has_many :logic_question_answers, -> { includes(:logic_question).order('logic_questions.position') }, dependent: :destroy, :inverse_of => :admission_application
  accepts_nested_attributes_for :logic_question_answers
  validates_associated :logic_question_answers, :if => :active?, :message => "must all be answered."

  has_many :profile_question_answers, -> { includes(:profile_question).order('profile_questions.position') }, dependent: :destroy, :inverse_of => :admission_application
  accepts_nested_attributes_for :profile_question_answers
  validates_associated :profile_question_answers, :if => :active?, :message => "must all be answered."

  accepts_nested_attributes_for :comments, reject_if: proc { |attributes| attributes['content'].blank? && attributes['id'].blank? }

  validates :last_name, :first_name, :address, :city, :state, :zip_code, :legal_status, :education, :employment_status, :goal, :referral_source, :phone, :presence => true, :if => :active_or_general?, length: {maximum: 255}
  validates :resume_link, presence: true, :if => :active?
  validates :website_link, :linkedin_account, :resume_link, :payment_option, :twitter_account, :github_account, :middle_name, length: {maximum: 255}
  validates_format_of :website_link, :linkedin_account, :with => URI::regexp(%w(http https)), allow_blank: true, message: "is not a valid URL", :if => :active_or_general?
  validates_format_of :resume_link, :with => URI::regexp(%w(http https)), allow_blank: true, message: "is not a valid URL", :if => :active?
  validates_format_of :phone, with: /\d{3}-\d{3}-\d{4}/, message: "is not formatted properly", allow_blank: true
  validates_numericality_of :income, allow_blank: true
  validates :payment_option, :presence => true, :if => :active?
  validates_acceptance_of :payment_plan, :if => :active?, :message => "must be acknowledged", allow_nil: false
  validates :income, :numericality => {:less_than_or_equal_to => 1000000, :message => "Seriously?"}, allow_blank: true

  STATUS_OPTIONS = {
      not_started: "Not Started",
      started: 'Started',
      complete: 'Complete',
      needs_scheduling: 'Needs Scheduling',
      scheduled: 'Scheduled',
      interview_passed: 'Interview Passed',
      placed: 'Placed',
      declined: 'Declined'
  }

  STATUS_FILTER_SCOPES = {
      completed: 'Completed',
      needs_interview_score: 'Needs Interview Score',
      accepted: 'Accepted'
  }

  COMMENT_TYPE = {
      call: 'Call Note',
      interview: 'Interview',
      technical: "Technical Challenge"
  }

  INTERVIEW_SCORES = [
      {id: '0', name: 'Not Interviewed'},
      {id: '1', name: 'Unsatisfactory'},
      {id: '3', name: 'Meets Expectations'},
      {id: '5', name: 'Exceptional'}
  ]

  def name
    "#{self.first_name} #{self.middle_name} #{self.last_name}" unless self.first_name.blank? || self.last_name.blank?
  end

  def full_address
    "#{self.address}\n#{self.city}, #{self.state} #{self.zip_code}" unless self.address.blank? || self.city.blank? || self.state.blank? || self.zip_code.blank?
  end

  def started?
    application_status != "not_started"
  end

  def completed?
    (application_status != "not_started" && application_status != "started")
  end

  def placed?
    application_status == "placed"
  end

  def active?
    # Allow for modification of records after submission (in scoring) without verification
    # TODO - this seems really fragile and error prone.  Come back and take a look at this.
    application_step == 'submit' && (application_status == "started" || application_status == "not_started" || application_status.blank?)
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

  def logic_questions_score
    score = 0
    logic_question_answers.each do |a|
      if a.logic_question.present?
        if a.answer != "I don't know"
          if a.answer == a.logic_question.solution
            score = score + 1
          else
            score = score - 1
          end
        end
      end
    end
    score
  end

  def profile_questions_score
    score = 0
    profile_question_answers.each do |a|
      score = score + a.score.to_i
    end
    score
  end

  def self.interview_score_options
    INTERVIEW_SCORES.map { |item| ["#{item[:id]} - #{item[:name]}", item[:id]] }
  end

  def self.application_status_options
    self.options_array_from_simple_hash(STATUS_OPTIONS)
  end

  def self.application_status_filter_scope_options
    self.options_array_from_simple_hash(STATUS_FILTER_SCOPES)
  end

  def self.comment_sub_type_options
    self.options_array_from_simple_hash(COMMENT_TYPE)
  end

  def application_status_name
    STATUS_OPTIONS[self.application_status.to_sym].blank? ? self.application_status : STATUS_OPTIONS[self.application_status.to_sym]
  end

  def interview_score_name
    name = self.interview_score
    if self.interview_score == 0
      name = ''
    else
      INTERVIEW_SCORES.each do |score|
        if self.interview_score.to_s == score[:id].to_s
          name = score[:name]
          break
        end
      end
    end
    name
  end

  private

  def init
    self.application_status ||= "not_started"
  end

  def self.is_status_filter_scope?(val)
    !STATUS_FILTER_SCOPES[val.to_sym].blank?
  end

  def send_welcome
    AdmissionApplicationMailer.admission_application_welcome(self).deliver
  end

  # Set or update Mailchimp list subscription for applicants
  def update_subscription(options = {app_status: "In Progress", adm_status: "Unevaluated"})
    Gibbon::API.lists.subscribe({:id => ENV['MAILCHIMP_LIST'], :email => {:email => self.user.email}, :merge_vars => {:FNAME => self.first_name, :LNAME => self.last_name, :APP_STATUS => options[:app_status], :ADM_STATUS => options[:adm_status], :GROUPINGS => [{:name => "I am a:", :groups => ['Applicant']}]}, :double_optin => false, :update_existing => true})
  end


  def update_status
    # After validation, detect if the application is being submitted and set completed flags
    if active?
      self.application_status = "complete"
      self.application_step = "thanks"
      self.completed_at = Time.now
      update_subscription(app_status: "Completed")
      AdmissionApplicationMailer.admission_application_thank_you(self).deliver
    else
      # Set the status to started if the status isn't set but the user has submitted
      # a page.
      if !self.application_step.nil? && self.application_status == 'not_started'
        self.application_status = "started"
      end
    end
  end

  # Converts a hash to an array for select option lists
  def self.options_array_from_simple_hash(hash)
    options_array = hash.map { |key, status| [status, key] }
  end

  def check_assigned_cohort
    self.assigned_cohort_id = nil unless self.placed?
  end

end
