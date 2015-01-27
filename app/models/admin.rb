class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments

  def name
    "#{self.first_name} #{self.last_name}" unless self.first_name.blank? || self.last_name.blank?
  end

  def name_and_email
    self.name.blank? ? self.email : "#{self.name} <#{self.email}>"
  end
end
