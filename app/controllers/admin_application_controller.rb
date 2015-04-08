class AdminApplicationController < ApplicationController
  included AdminApplicationHelper
  before_filter :authenticate_admin!
  before_action :set_display_page_header
  layout :layout_by_resource

  def set_display_page_header
    @display_page_header = true
  end

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "admin"
    end
  end

end