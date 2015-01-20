class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :sub_type
      t.references :admin, index: true
      t.references :is_commentable, polymorphic: true, index: true

      t.timestamps
    end
  end

  def data
    admin = Admin.find_by(email: 'admin@primeacademy.io')
    AdmissionApplication.where.not("resume_notes" => nil).each do |app|
      app.comments.create(content: app.resume_notes, admin: admin, sub_type: 'technical')
    end
  end

end
