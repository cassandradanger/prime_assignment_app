class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        session[:user_created] = 1
      end
    end
  end
end