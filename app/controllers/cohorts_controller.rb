class CohortsController < AdminApplicationController
  before_action :set_cohort, only: [:show, :edit, :update, :destroy]
  before_action :set_courses, only: [:new, :create]

  respond_to :html

  def index
    set_default_params(:status)
    @cohorts = Cohort.filter(params.slice(:status))
    @status_filter = params[:status]
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
    if @cohort.save
      respond_with(@cohort)
    else
      render :new
    end
  end

  def update
    if @cohort.update(cohort_params)
      respond_with(@cohort)
    else
      render :edit
    end
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
      when 'gender'
        render json: Cohort.find(params[:cohort_id]).assigned_admission_applications.has_referral.group(:gender).count
      when 'payment_option'
        render json: Cohort.find(params[:cohort_id]).assigned_admission_applications.all_completed.group(:payment_option).count
      when 'age'
        # render json: Cohort.find(params[:cohort_id]).assigned_admission_applications.completed.group("date_part('year',age(birthdate))").order("date_part_year_age_birthdate").count
        render json: Cohort.find(params[:cohort_id]).accepted_applicants_by_age_group
      when 'created_and_completed'
        filter = 90.days.ago.midnight
        case params[:time_filter]
          when 'week'
            filter = 1.week.ago.midnight
          when 'month'
            filter = 1.month.ago.midnight
        end
        @new_users_date60 = Cohort.find(params[:cohort_id]).assigned_admission_applications.group_by_day(:created_at, range: filter..DateTime.now, format: "%m/%d/%Y").count
        @apps_by_create_date60 = Cohort.find(params[:cohort_id]).assigned_admission_applications.started.group_by_day(:created_at, range: filter..DateTime.now, format: "%m/%d/%Y").count
        @apps_by_completed_date60 = Cohort.find(params[:cohort_id]).assigned_admission_applications.all_completed.group_by_day(:completed_at, range: filter..DateTime.now, format: "%m/%d/%Y").count
        render json: merge_started_and_complete
    end
  end


  private
  def set_cohort
    @cohort = Cohort.find(params[:id])
  end

  def set_courses
    @courses = Course.active
  end

  def cohort_params
    params.require(:cohort).permit(:name, :prework_start, :classroom_start, :graduation, :applications_open, :applications_close, :target_size, :earnest_application_code, :course_id)
  end

  def set_default_params(param)
    session_name = "cohort_#{param}_filter".to_sym
    params[param] ||= session[session_name]
    session[session_name] = params[param]
  end

  def group_apps_by_age
    apps = Cohort.find(params[:cohort_id]).assigned_admission_applications
    output = {}

  end
end
