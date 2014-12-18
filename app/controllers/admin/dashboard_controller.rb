class Admin::DashboardController < ApplicationController
  require('groupdate')
  before_filter :authenticate_admin!

  def index

    @apps_count = AdmissionApplication.count
    @apps_completed_count = AdmissionApplication.completed.count
    @apps_by_create_date60 = AdmissionApplication.where('created_at > ?',60.days.ago).group_by_day(:created_at).count
    @apps_by_completed_date60 = AdmissionApplication.completed.where('created_at > ?',60.days.ago).group_by_day(:created_at).count
    @apps_by_referral_source = AdmissionApplication.group(:referral_source).count
    @apps_by_referral_source_date60 = AdmissionApplication.where('created_at > ?',60.days.ago).group(:referral_source).group_by_day(:created_at).count
  end
end
