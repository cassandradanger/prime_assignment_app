class UpdateCommentCallNoteSubType < ActiveRecord::Migration
  def data
    comment = Comment.unscoped.where(sub_type: "call note")
    comment.each do |c|
      c.sub_type = "call"
      c.save
    end
  end
end
