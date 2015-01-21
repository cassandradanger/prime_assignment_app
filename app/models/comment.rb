class Comment < ActiveRecord::Base
  belongs_to :is_commentable, polymorphic: true
  belongs_to :admin

  scope :technical, -> { where(sub_type: "technical") }
  scope :call_note, -> { where(sub_type: "call note") }
  scope :interview, -> { where(sub_type: "interview") }

  validates :content, :admin, presence: true


end