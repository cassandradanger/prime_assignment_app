class AdmissionApplication < ActiveRecord::Base
  include Workflow
  include Filterable

  audited on: [:create, :update], except: [:application_status_updated_at, :completed_at, :application_step]

  paginates_per 50

  scope :all_completed, -> { where.not(application_status: 'not_started').where.not(application_status: 'started') }
  scope :started, -> { where.not(application_status: 'not_started') }
  scope :accepted, -> { where(application_status: ['interview_passed', 'placed', 'confirmed']) }
  scope :placed, -> { where(application_status: 'placed') }
  scope :all_declined, -> { where(application_status: ['declined_by_applicant', 'declined_action_required', 'declined']) }
  scope :being_processed, -> { where(application_status: ['completed', 'needs_scheduling', 'scheduled', 'interview_passed', 'placed']) }
  scope :needs_interview_score, -> { where(application_status: ['scheduled', 'interview_passed', 'placed']).where(interview_score: 0) }
  scope :has_referral, -> { started.where.not(referral_source: nil) }
  scope :app_status, -> (status) { (self.is_status_filter_scope?(status)) ? send(status) : where(application_status: status) }
  scope :assigned_cohort, -> (cohort) { where(assigned_cohort: cohort) }
  scope :cohort, lambda { |n| joins(:cohorts).where('cohorts.id = ?', n) }

  # scope :aid_eligible, -> { where(income: 0...23340) }
  scope :aid_ineligible, -> { where("(income > 23341 AND (dependents = 0 OR dependents IS NULL)) OR (income > 31460 AND dependents = 1) OR (income > 39580 AND dependents = 2) OR (income > 47700 AND dependents = 3) OR (income > 55820 AND dependents = 4) OR (income > 63940 AND dependents = 5) OR (income > 72060 AND dependents = 6) OR (income > 80180 AND dependents = 7)") }
  scope :aid_eligible, -> { where("(income <= 23341 AND (dependents = 0 OR dependents IS NULL)) OR (income <= 31460 AND dependents = 1) OR (income <= 39580 AND dependents = 2) OR (income <= 47700 AND dependents = 3) OR (income <= 55820 AND dependents = 4) OR (income <= 63940 AND dependents = 5) OR (income <= 72060 AND dependents = 6) OR (income <= 80180 AND dependents = 7)") }
  scope :aid_seeking, -> { where(payment_option: "Scholarship") }
  scope :not_aid_seeking, -> { where.not(payment_option: "Scholarship") }

  before_validation :populate_questions_on_submit
  before_save :update_status, :check_assigned_cohort, :check_for_status_change
  after_save :update_email_subscriptions

  after_initialize :init

  after_create :populate_questions, on: :create
  after_create :send_welcome

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
      not_started: 'Not Started',
      started: 'Started',
      completed: 'Completed',
      needs_scheduling: 'Needs Scheduling',
      scheduled: 'Scheduled',
      interview_passed: 'Interview Passed',
      placed: 'Placed',
      confirmed: 'Confirmed',
      declined_by_applicant: 'Declined by Applicant',
      declined_action_required: 'Declined, Action Required',
      declined: 'Declined'
  }

  STATUS_FILTER_SCOPES = {
      all_completed: 'Completed',
      being_processed: 'In Process',
      needs_interview_score: 'Needs Interview Score',
      accepted: 'Accepted',
      all_declined: 'Declined'
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

  # Workflow definition
  # Override the default column used by the Workflow gem to use the application_status column.
  workflow_column :application_status

  workflow do
    state :not_started, :meta => {:name => 'Not Started'} do
      event :start, :transitions_to => :started
    end
    state :started, :meta => {:name => 'Started'} do
      event :complete, :transitions_to => :completed
    end
    state :completed, :meta => {:name => 'Completed'} do
      event :need_schedule, :transitions_to => :needs_scheduling, :meta => {:btn_class => 'btn-primary'}
      event :decline, :transitions_to => :declined, :meta => {:btn_class => 'btn-danger', :group => :declined}
      event :decline_with_action, :transitions_to => :declined_action_required, :meta => {:btn_class => 'btn-danger', :group => :declined}
      # See on_completed_entry
    end
    state :needs_scheduling, :meta => {:name => 'Needs Scheduling'} do
      event :schedule, :transitions_to => :scheduled, :meta => {:btn_class => 'btn-primary'}
      event :decline, :transitions_to => :declined, :meta => {:btn_class => 'btn-danger'}
    end
    state :scheduled, :meta => {:name => 'Scheduled'} do
      event :interview_pass, :transitions_to => :interview_passed, :meta => {:btn_class => 'btn-primary'}
      event :decline, :transitions_to => :declined, :meta => {:btn_class => 'btn-danger', :group => :declined}
      event :decline_with_action, :transitions_to => :declined_action_required, :meta => {:btn_class => 'btn-danger', :group => :declined}
    end
    state :interview_passed, :meta => {:name => 'Interview Passed'} do
      event :place, :transitions_to => :placed, :meta => {:btn_class => 'btn-primary'}
      event :decline, :transitions_to => :declined, :meta => {:btn_class => 'btn-danger', :group => :declined}
      event :decline_with_action, :transitions_to => :declined_action_required, :meta => {:btn_class => 'btn-danger', :group => :declined}
      event :decline_by_applicant, :transitions_to => :declined_by_applicant, :meta => {:btn_class => 'btn-danger', :group => :declined}
    end
    state :placed, :meta => {:name => 'Placed'} do
      event :confirm, :transitions_to => :confirmed, :meta => {:btn_class => 'btn-primary'}
      event :decline, :transitions_to => :declined, :meta => {:btn_class => 'btn-danger', :group => :declined}
      event :decline_with_action, :transitions_to => :declined_action_required, :meta => {:btn_class => 'btn-danger', :group => :declined}
      event :decline_by_applicant, :transitions_to => :declined_by_applicant, :meta => {:btn_class => 'btn-danger', :group => :declined}
    end
    state :confirmed, :meta => {:name => 'Confirmed'} do
      event :drop, :transitions_to => :dropped_out, :meta => {:btn_class => 'btn-danger'}
    end
    state :declined, :meta => {:name => 'Declined'}
    state :declined_action_required, :meta => {:name => 'Declined - Action Required'}
    state :declined_by_applicant, :meta => {:name => 'Declined by Applicant'}
    state :dropped_out, :meta => {:name => 'Dropped Out'}

    # on_transition do |from, to, triggering_event, *event_args|
    # end
  end

  # Workflow event handlers
  def on_completed_entry(from, triggering_event, *event_args)
    self.application_step = "thanks"
    self.completed_at = Time.now
    AdmissionApplicationMailer.admission_application_thank_you(self).deliver_now
  end

  # End of Workflow definition

  def name
    "#{self.first_name} #{self.middle_name} #{self.last_name}" unless self.first_name.blank? || self.last_name.blank?
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def assigned_cohort_name
    self.assigned_cohort.name unless self.assigned_cohort_id.blank?
  end

  def full_address
    "#{self.address}\n#{self.city}, #{self.state} #{self.zip_code}" unless self.address.blank? || self.city.blank? || self.state.blank? || self.zip_code.blank?
  end

  def completed_by_applicant?
    self.current_state >= :completed
  end

  def placed_or_confirmed?
    self.placed? || self.confirmed?
    # application_status == "placed" || application_status == 'confirmed'
  end

  def active?
    # Allow for modification of records after submission (in scoring) without verification
    # TODO - this seems really fragile and error prone.  Come back and take a look at this.
    application_step == 'submit' && self.current_state < :completed
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
    if self.completed_by_applicant?
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
  end

  def profile_questions_score
    if self.completed_by_applicant?
      score = 0
      profile_question_answers.each do |a|
        score = score + a.score.to_i
      end
      score
    end
  end

  def self.interview_score_options
    INTERVIEW_SCORES.map { |item| ["#{item[:id]} - #{item[:name]}", item[:id]] }
  end

  def self.workflow_state_name key
    AdmissionApplication.workflow_spec.states[key].meta[:name]
  end

  def self.application_status_options
    options_list = AdmissionApplication.workflow_spec.states.keys.map { |key| [AdmissionApplication.workflow_state_name(key), key] }
  end

  def self.application_status_filter_scope_options
    self.options_array_from_simple_hash(STATUS_FILTER_SCOPES)
  end

  def self.comment_sub_type_options
    self.options_array_from_simple_hash(COMMENT_TYPE)
  end

  def application_status_name
    self.current_state.meta[:name]
  end

  def days_since_status_update
    if self.completed_by_applicant?
      days = (DateTime.now - self.application_status_updated_at.to_datetime).to_i
      case days
        when 0
          days = 'Today'
        when 1
          days = 'Yesterday'
        else
          days = "#{days} days ago"
      end
      days
    end
  end

  def interview_score_name
    if self.completed_by_applicant?
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
  end

  # Set or update Mailchimp list subscription for completed
  def update_mailchimp
    options = {
        id: ENV['MAILCHIMP_LIST'],
        email: {:email => self.user.email},
        double_optin: false,
        update_existing: true,
        merge_vars: {
            FNAME: self.first_name,
            LNAME: self.last_name,
            APP_STATUS: self.application_status,
            ADM_STATUS: (self.placed_or_confirmed? ? "Accepted" : "Unevaluated"),
            AID_ELIG: (AdmissionApplication.aid_eligible.exists?(self.id) ? "YES" : ""),
            GROUPINGS: [{:name => "I am a:", :groups => ['Applicant']}]
        }
    }
    if (self.placed_or_confirmed? && !self.assigned_cohort.nil?)
      options[:merge_vars][:COHORT] = self.assigned_cohort.id
      options[:merge_vars][:START_ON] = self.assigned_cohort.prework_start
    else
      options[:merge_vars][:COHORT] = ""
      options[:merge_vars][:START_ON] = ""
    end
    begin
      Gibbon::API.lists.subscribe(options)
    rescue Gibbon::MailChimpError => e
      Rails.logger.error "Gibbon::MailChimpError: #{e.code} - #{e.message}"
    end

  end

  def persist_workflow_state(new_value)
    # We are overriding the persist_workflow_state method to use an update call.
    # We need to use update for the change to write to the audit log.
    # TODO - come back and see if we can try to use update_attribute by adding that to audited.
    update(self.class.workflow_column.to_sym => new_value, audit_comment: 'Workflow')
  end

  private
  def init

  end

  def self.is_status_filter_scope?(val)
    !STATUS_FILTER_SCOPES[val.to_sym].blank?
  end

  def send_welcome
    AdmissionApplicationMailer.admission_application_welcome(self).deliver_now
  end

  def update_status
    # After validation, detect if the application is being submitted and set completed flags
    if active?
      self.complete!
    else
      # Set the status to started if the status isn't set but the user has submitted
      if !self.application_step.nil? && self.not_started?
        self.start!
      end
    end
  end

  # Converts a hash to an array for select option lists
  def self.options_array_from_simple_hash(hash)
    options_array = hash.map { |key, status| [status, key] }
  end

  def check_assigned_cohort
    # Reset the cohort unless the user is placed, confirmed or has dropped out.
    self.assigned_cohort_id = nil unless self.placed_or_confirmed? || self.dropped_out?
    # If the cohort is set but the app's status is set to placed, then move it to confirmed.
    # if self.placed? && self.assigned_cohort != nil
    #   self.confirm!
    # end
  end

  def check_for_status_change
    if self.application_status_changed?
      self.application_status_updated_at = DateTime.now
    end
  end

  def update_email_subscriptions
    # This is a bit of a hack.  I got tired of trying to figure out how to tell if assigned_cohort had
    # changed.  The _changed? method doesn't work because it is an association.  So instead of updating
    # MailChimp on assigned_cohort_changed? I am updating it on every save if the state is at or above 'placed'.
    if self.application_status_changed? || self.current_state >= :placed
      self.update_mailchimp
    end
  end

end
