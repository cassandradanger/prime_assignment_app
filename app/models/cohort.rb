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
  validates :earnest_application_code, :presence => true

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
    # Status is based on where the cohort is in the process. - Date Based.
    status = 'Unknown'
    case
      when Date.today <= applications_open
        status = 'Pre-Applications'
      when Date.today <= applications_close
        status = 'Applications Open'
      when Date.today <= prework_start
        status = 'Applications Closed'
      when Date.today <= classroom_start
        status = 'Prework'
      when Date.today <= graduation
        status = 'Classroom'
      else
        status = 'Complete'
    end
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

  def accepted_applicants_by_age_group
    rtn = AdmissionApplication.select('(s.d * 5)')
              .from('generate_series(0, 20) s(d)')
              .joins("left outer join admission_applications a on s.d = floor(date_part('year',age(a.birthdate)) / 5)")
              .where('a.assigned_cohort_id = ?', self.id)
              .group('s.d')
              .order('s.d').count
    rtn2 = Hash.new
    start_pos = 3
    end_pos = 10
    if !rtn.blank?
      end_pos = (rtn.keys[rtn.length-1]<end_pos)?end_pos:rtn.keys[rtn.length-1]
    end
    for i in start_pos..end_pos
      val = rtn[i].blank? ? 0 : rtn[i]
      rtn2["#{(i*5)} - #{(i*5)+4}"]=val
    end
    rtn2
  end

  protected
  def pct_of_target(num)
    val = (num.fdiv(self.target_size)*100).to_int
    val = 100 if val > 100
    val = 0 if val < 0
    val
  end
end
