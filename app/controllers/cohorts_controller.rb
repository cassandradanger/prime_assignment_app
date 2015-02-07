class CohortsController < AdminApplicationController
  before_action :set_cohort, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cohorts = Cohort.all
    respond_with(@cohorts)
  end

  def show
    respond_with(@cohort)
  end

  def new
    @cohort = Cohort.new
    respond_with(@cohort)
  end

  def edit
  end

  def create
    @cohort = Cohort.new(cohort_params)
    @cohort.save
    respond_with(@cohort)
  end

  def update
    @cohort.update(cohort_params)
    respond_with(@cohort)
  end

  def destroy
    @cohort.destroy
    respond_with(@cohort)
  end

  def chart
    case params[:type]
      when 'referral_source'
        render json: Cohort.find(params[:cohort_id]).assigned_admission_applications.has_referral.group(:referral_source).count
      when 'education'
        render json: Cohort.find(params[:cohort_id]).assigned_admission_applications.has_referral.group(:education).count
      when 'payment_option'
        render json: Cohort.find(params[:cohort_id]).assigned_admission_applications.completed.group(:payment_option).count
      when 'created_and_completed'
        filter = 90.days.ago.midnight
        case params[:time_filter]
          when 'week'
            filter = 1.week.ago.midnight
          when 'month'
            filter =  1.month.ago.midnight
        end
        @new_users_date60 = Cohort.find(params[:cohort_id]).assigned_admission_applications.group_by_day(:created_at, range: filter..DateTime.now, format: "%m/%d/%Y").count
        @apps_by_create_date60 = Cohort.find(params[:cohort_id]).assigned_admission_applications.started.group_by_day(:created_at, range: filter..DateTime.now, format: "%m/%d/%Y").count
        @apps_by_completed_date60 = Cohort.find(params[:cohort_id]).assigned_admission_applications.completed.group_by_day(:completed_at, range: filter..DateTime.now, format: "%m/%d/%Y").count
        render json: merge_started_and_complete
    end
  end


  private
    def set_cohort
      @cohort = Cohort.find(params[:id])
    end

    def cohort_params
      params.require(:cohort).permit(:name, :prework_start, :classroom_start, :graduation, :applications_open, :applications_close, :target_size)
    end
end
