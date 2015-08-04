class TestingController < ApplicationController



  # For testing timeouts
  def timeout
    sleep 30
    render plain: "Done"
  end

  def email
    apps = AdmissionApplication.includes(:user).where(users: {email: 'mikes@nerdery.com'})

    @d1 = nil
    @d2 = nil

    apps.each do |a|
      @d1 = Delayed::Job.enqueue Email::Application::ThankYouEmailJob.new(a.id)
      @d2 = Delayed::Job.enqueue Email::Application::WelcomeEmailJob.new(a.id)
    end
    render layout: false
  end

  def ping
    render plain: "OK"
  end
end
