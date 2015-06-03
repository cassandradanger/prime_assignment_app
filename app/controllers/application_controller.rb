class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource

  def audited_user
    current_user
  end

  protected

  # Override the layout for the admin login page.
  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin-simple"
    else
      "application"
    end
  end
end
