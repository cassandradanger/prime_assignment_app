class Cohort < ActiveRecord::Base
  include Filterable

  default_scope { order(:id) }
  scope :current, -> { where("? BETWEEN applications_open AND applications_close", Date.today).order(applications_close: :asc) }
  scope :pre_class, -> { where("? < classroom_start", Date.today) }
  scope :active, -> { where("? <= graduation", Date.today) }
  scope :status, -> (status) { send(status) }

  has_and_belongs_to_many :admission_applications
  has_many :assigned_admission_applications, class_name: "AdmissionApplication", foreign_key: "assigned_cohort_id", inverse_of: 'assigned_cohort'

  validates :target_size, :presence => true
  validates_numericality_of :target_size

  def label
    "#{self.classroom_start.to_formatted_s(:long)} - #{self.graduation.to_formatted_s(:long)} (Prework begins #{self.prework_start.to_formatted_s(:long)})"
  end

  def has_applications?
    self.admission_applications.count > 0
  end

  def active?
    Date.today <= self.graduation
  end

  def status
    status = 'Active'
    status = 'Inactive' unless self.active?
    status
  end

  def accepted_application_count
    self.assigned_admission_applications.count
  end

  def confirmed_application_count
    AdmissionApplication.where("assigned_cohort_id = ? AND application_status = 'confirmed'", self.id).count
  end

  def accepted_application_pct
    self.pct_of_target(self.assigned_admission_applications.count)
  end
  def confirmed_application_pct
    pct_of_target(self.confirmed_application_count)
  end

  protected
  def pct_of_target(num)
    val = (num.fdiv(self.target_size)*100).to_int
    val = 100 if val > 100
    val = 0 if val < 0
    val
  end
end
