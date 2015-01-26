class DashboardController < AdminApplicationController
  require('groupdate')

  def index
    @user_count = User.count
    @apps_count = AdmissionApplication.started.count
    @apps_completed_count = AdmissionApplication.completed.count
    @apps_accepted_count = AdmissionApplication.accepted.count
    # @apps_by_create_date60 = AdmissionApplication.started.where('created_at > ?', 60.days.ago).group_by_day(:created_at, format: "%m/%d/%Y").count
    # @apps_by_completed_date60 = AdmissionApplication.completed.where('completed_at > ?', 60.days.ago).group_by_day(:completed_at, format: "%m/%d/%Y").count
    # @apps_by_create_date60.merge(@apps_by_completed_date60)
    # @apps_by_accepted_date60 = AdmissionApplication.accepted.where('created_at > ?', 60.days.ago).group_by_day(:created_at, format: "%m/%d").count
    # @apps_by_payment_option = AdmissionApplication.completed.group(:payment_option).count
    # @apps_by_referral_source = AdmissionApplication.has_referral.group(:referral_source).count
    # @apps_by_referral_source_date7 = AdmissionApplication.has_referral.where('created_at >= ?', 60.days.ago).group(:referral_source).group_by_day(:created_at, format: "%m/%d/%Y").count
    # @apps_by_created_and_completed_date60 = merge_started_and_complete
  end

  def chart
    case params[:type]
      when 'referral_source'
        render json: AdmissionApplication.has_referral.group(:referral_source).count
      when 'education'
        render json: AdmissionApplication.has_referral.group(:education).count
      when 'payment_option'
        render json: AdmissionApplication.completed.group(:payment_option).count
      when 'created_and_completed'
        @apps_by_create_date60 = AdmissionApplication.started.where('created_at > ?', 60.days.ago).group_by_day(:created_at, format: "%m/%d/%Y").count
        @apps_by_completed_date60 = AdmissionApplication.completed.where('completed_at > ?', 60.days.ago).group_by_day(:completed_at, format: "%m/%d/%Y").count
        render json: merge_started_and_complete
    end
  end

  def set_display_page_header
    @display_page_header = false
  end

  private
  def merge_started_and_complete
    [
        {name: "Started", data: @apps_by_create_date60},
        {name: "Complete", data: @apps_by_completed_date60}
    ]
  end
end
