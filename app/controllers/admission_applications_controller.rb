class AdmissionApplicationsController < AdminApplicationController
  before_action :set_admission_application, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    set_default_params(:cohort)
    set_default_params(:assigned_cohort)
    set_default_params(:app_status)

    respond_to do |format|
      format.html do
        @admission_applications_count = AdmissionApplication.filter(params.slice(:cohort,:assigned_cohort,:app_status)).count
        @status_options = [['Status',AdmissionApplication.application_status_options],['Filter',AdmissionApplication.application_status_filter_scope_options]]
        @cohort_id = params[:cohort]
        @app_status = params[:app_status]
        @assigned_cohort_id = params[:assigned_cohort]
        @cohorts = Cohort.all
      end
      format.json { render json: AdmissionApplicationDatatable.new(view_context, params)}
    end
  end

  def show
    @admission_application
    @audits = @admission_application.audits
    @tech_comment = @admission_application.comments.build(sub_type: "technical", admin: current_admin)
    @new_comment = Comment.new(sub_type: "call")
    @new_interview_comment = Comment.new(sub_type: "interview")
    @cohorts = Cohort.all
  end

  def audit_log
    @audit_log = @admission_application.audits
  end

  def edit
    @cohorts = Cohort.all
  end

  def update
    # raise admission_application_params.to_yaml
    p = admission_application_params
    if @admission_application.update(p)
      flash[:success] = "Application updated successfully!"
    end
    respond_with(@admission_application)
  end

  def destroy
    # @admission_application.destroy
    # respond_with(@admission_application)
  end

  def workflow
    @admission_application = AdmissionApplication.find(params[:id])
    if @admission_application.process_event! params[:workflow_action]
      redirect_to(admission_application_path @admission_application)
    end
  end

  private
    def set_admission_application
      @admission_application = AdmissionApplication.includes(:comments => :admin).find(params[:id])
    end

    def admission_application_params
      params[:admission_application]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_application_params
      params.require(:admission_application).permit(:first_name, :middle_name, :last_name, :phone, :address, :city, :state, :zip_code,
                                                    :legal_status, :education, :employment_status, :goal, :income, :linkedin_account,
                                                    :twitter_account, :github_account, :website_link, :referral_source, :resume_link,
                                                    :payment_plan, :payment_option, :resume_score, :resume_notes, :application_status,
                                                    :interview_score, :assigned_cohort_id, :birthdate, :gender, :race_hispanic,
                                                    :race_nativeamerican, :race_asian, :race_black, :race_islander, :race_white,
                                                    :race_other, :dependents, :geography, :veteran, :audit_comment,
                                                    :logic_question_answers_attributes => [:id,:logic_question_id,:answer,:explanation],
                                                    :profile_question_answers_attributes => [:id,:profil_question_id,:answer,:score],
                                                    :cohort_ids => [],
                                                    :comments_attributes => [:id, :content, :sub_type, :admin_id])
    end

    def set_default_params(param)
      session_name = "admission_application_#{param}_filter".to_sym
      params[param] ||= session[session_name]
      session[session_name] = params[param]
    end

end
