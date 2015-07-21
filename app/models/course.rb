class Course < ActiveRecord::Base

  scope :active, -> { where(active: true) }

  has_many :admission_applications
  has_many :cohorts
  has_many :logic_questions
  has_many :profile_questions

  validates :code, uniqueness: true, presence: true
  validates :name, presence: true

  # Force code to be upper case
  def code=(val)
    self[:code] = val.upcase
  end

  def label
    "#{code} - #{name}"
  end
end
