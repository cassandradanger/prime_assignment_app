class AdminApplicationController < ApplicationController
  before_filter :authenticate_admin!
  layout 'application-admin'
end