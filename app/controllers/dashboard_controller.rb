class DashboardController < ApplicationController
  require('groupdate')
  before_filter :authenticate_admin!
  layout 'application-admin'

  def index
    @user_count = User.count
    @apps_count = AdmissionApplication.started.count
    @apps_completed_count = AdmissionApplication.completed.count
    @apps_by_create_date60 = AdmissionApplication.started.where('created_at > ?',60.days.ago).group_by_day(:created_at).count
    @apps_by_completed_date60 = AdmissionApplication.completed.where('created_at > ?',60.days.ago).group_by_day(:created_at).count
    @apps_by_referral_source = AdmissionApplication.has_referral.group(:referral_source).count
    @apps_by_referral_source_date60 = AdmissionApplication.has_referral.where('created_at > ?',60.days.ago).group(:referral_source).group_by_day(:created_at).count
  end
end
