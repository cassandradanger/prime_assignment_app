module Email
  module Application
    class BaseApplicationEmailJob < Struct.new(:admission_application_id)
      class_attribute :queue_as, :template_name
      self.queue_as = 'email'

      def mandrill_client
        @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_APIKEY']
      end

      def send_mail(message, template_content = [])
        mandrill_client.messages.send_template self.template_name, template_content, message
      end

      # Use the enqueue method to capture the Application ID and class type.
      def enqueue(job)
        job.delayed_reference_id = admission_application_id
        job.delayed_reference_type = 'AdmissionApplication'
        job.save!
      end

      def queue_name
        self.queue_as
      end
    end
  end
end