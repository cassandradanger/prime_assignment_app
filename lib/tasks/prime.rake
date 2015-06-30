namespace :prime do

  desc "Can be used to change email addresses in a database dump to 'dev' + id '@junk.com'"
  task clean_email_from_data: :environment do
     if Rails.env.development?
       puts "Replacing email addresses in `users` to 'dev' || users.id || '@junk.com'"
       @users = User.all
       counter = 0
       error_count = 0
       @users.each do |user|
          user.email = "dev#{user.id}@junk.com"
          if user.save
             counter+= 1
          else
             error_count+= 1
          end
       end
       puts "#{counter} user records updated."
       if error_count > 0
          puts "#{error_count} ERRORS on user."
       end
       puts "Replacing email addresses in `admission_applications` to 'dev' || users.id || '@junk.com'"
       @apps = AdmissionApplication.all
       counter = 0
       error_count = 0
       @apps.each do |app|
          app.email = "dev#{app.user.id}@junk.com"
          if app.save
             counter += 1
          else
             error_count += 1
          end
       end 
       puts "#{counter} admission_applications records updated."
       if error_count > 0
          puts "#{error_count} ERRORS on admission_applications."
       end
     else
       puts "FAILED! This will only run in development!"
     end
  end
  task update_mailchimp: :environment do
    puts "Begin updating all MailChimp subscriptions"
    @apps = AdmissionApplication.all
    counter = 0
    @apps.each do |app|
      app.update_mailchimp
      counter += 1
      if counter % 10 == 0
        print "*"
        STDOUT.flush
      end
    end
    puts " "
    puts "Complete"

  end
end
