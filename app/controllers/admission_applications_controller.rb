class AdmissionApplicationsController < AdminApplicationController
  before_action :set_admission_application, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    set_default_params(:cohort)
    set_default_params(:app_status)

    @admission_applications = AdmissionApplication.filter(params.slice(:cohort,:app_status))
    @status_options = [['Status',AdmissionApplication.application_status_options],['Filter',AdmissionApplication.application_status_filter_scope_options]]
    @cohort_id = params[:cohort]
    @app_status = params[:app_status]
    @cohorts = Cohort.all
  end

  def show
    @admission_application
    @tech_comment = @admission_application.comments.build(sub_type: "technical", admin: current_admin)
    @new_comment = Comment.new(sub_type: "call note")
    @new_interview_comment = Comment.new(sub_type: "interview")
  end

  def edit
  end

  def update
    # raise admission_application_params.to_yaml
    flash[:success] = "Application updated successfully!" if @admission_application.update(admission_application_params)
    respond_with(@admission_application)
  end

  def destroy
    @admission_application.destroy
    respond_with(@admission_application)
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
