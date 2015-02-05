class Cohort < ActiveRecord::Base
	scope :current, -> { where("? BETWEEN applications_open AND applications_close", Date.today).order(applications_close: :asc)}
	has_and_belongs_to_many :admission_applications

  has_many :assigned_admission_applications , class_name: "AdmissionApplication", foreign_key: "assigned_cohort_id", inverse_of: 'assigned_cohort'

	validates :target_size, :presence => true
	validates_numericality_of :target_size

	def label
		"#{self.classroom_start.to_formatted_s(:long)} - #{self.graduation.to_formatted_s(:long)} (Prework begins #{self.prework_start.to_formatted_s(:long)})"
	end
end
