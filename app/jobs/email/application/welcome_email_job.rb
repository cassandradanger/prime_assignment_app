module Email
  module Application
    class WelcomeEmailJob < BaseApplicationEmailJob
      self.queue_as = 'welcome_email'
      self.template_name = 'welcome-primeacademy-io'

      def perform
        @application = AdmissionApplication.find(admission_application_id)
        message = {
            to: [{email: @application.user.email, name: "#{@application.first_name} #{@application.last_name}"}]
        }
        send_mail(message)
      end
    end
  end
end