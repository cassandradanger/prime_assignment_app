class AdminApplicationController < ApplicationController
  included AdminApplicationHelper
  before_filter :authenticate_admin!
  layout 'application-admin'
end