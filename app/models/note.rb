class Note < ActiveRecord::Base
  belongs_to :notable, polymorphic: true
  belongs_to :admin

  validates_presence_of :admin
end
