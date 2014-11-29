class Cohort < ActiveRecord::Base
	scope :current, -> { where("? BETWEEN applications_open AND applications_close", Date.today).order(applications_close: :asc)}
	has_and_belongs_to_many :admission_applications

	def label
		"#{self.classroom_start.to_formatted_s(:long)} - #{self.graduation.to_formatted_s(:long)} (Prework begins #{self.prework_start.to_formatted_s(:long)})"
	end
end
