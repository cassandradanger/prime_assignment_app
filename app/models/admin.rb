class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments

  def name
    "#{self.first_name} #{self.last_name}" unless self.first_name.blank? || self.last_name.blank?
  end

  def name_or_email
    self.name.blank? ? self.email : self.name
  end

  def name_and_email
    self.name.blank? ? self.email : "#{self.name} <#{self.email}>"
  end

  def status_is_active?
    self.status == 'Active'
  end

  def active_for_authentication?
    super && self.status_is_active?
  end

  def inactive_message
    self.status_is_active? ? super : :account_inactive
  end
end
