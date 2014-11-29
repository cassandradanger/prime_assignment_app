class AdmissionApplicationMailer < ActionMailer::Base
    default from: "admissions@primeacademy.io"
    layout "email"

    def admission_application_welcome(admission_application)
        @user = admission_application.user
        mail(to: @user.email, subject: 'Your Application')
    end

    def admission_application_thank_you(admission_application)
        @user = admission_application.user
        mail(to: @user.email, subject: 'Your Application')
    end

end
