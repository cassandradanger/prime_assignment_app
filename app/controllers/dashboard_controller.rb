class DashboardController < AdminApplicationController
  require('groupdate')

  def index
    @user_count = User.count
    @apps_count = AdmissionApplication.started.count
    @apps_completed_count = AdmissionApplication.completed.count
    @apps_accepted_count = AdmissionApplication.accepted.count
    @app_line_time_filter = set_apps_time_filter
    @user_filter_count = User.where('created_at > ?', @time_filter).count
    @apps_started_filter_count = AdmissionApplication.started.where('created_at > ?', @time_filter).count
    @apps_completed_filter_count = AdmissionApplication.completed.where('completed_at > ?', @time_filter).count
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
        set_apps_time_filter
        @new_users_date60 = AdmissionApplication.group_by_day(:created_at, range: @time_filter..DateTime.now, format: "%m/%d/%Y").count
        @apps_by_create_date60 = AdmissionApplication.started.group_by_day(:created_at, range: @time_filter..DateTime.now, format: "%m/%d/%Y").count
        @apps_by_completed_date60 = AdmissionApplication.completed.group_by_day(:completed_at, range: @time_filter..DateTime.now, format: "%m/%d/%Y").count
        render json: merge_started_and_complete
    end
  end

  def set_display_page_header
    @display_page_header = false
  end

  private
  def merge_started_and_complete
    [
        {name: "New Users", data: @new_users_date60},
        {name: "Started", data: @apps_by_create_date60},
        {name: "Complete", data: @apps_by_completed_date60}
    ]
  end

  def set_apps_time_filter
    if params[:apps_time_filter].blank?
      filter = cookies[:dashboard_apps_time_filter].blank? ? 'quarter' : cookies[:dashboard_apps_time_filter]
    else
      cookies[:dashboard_apps_time_filter] = params[:apps_time_filter]
      filter = params[:apps_time_filter]
    end
    @time_filter = 90.days.ago.midnight
    @time_filter_days = 90
    case filter
      when 'week'
        @time_filter = 1.week.ago.midnight
        @time_filter_days = 7
      when 'month'
        @time_filter =  1.month.ago.midnight
        @time_filter_days = (Date.today - 1.month.ago.to_date).to_i
    end
    filter
  end

end
