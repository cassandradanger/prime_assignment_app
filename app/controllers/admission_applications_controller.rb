class AdmissionApplicationsController < AdminApplicationController
  before_action :set_admission_application, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cohort_id = params[:cohort_id] || nil
    if @cohort_id
      @admission_applications = Cohort.find(params[:cohort_id]).admission_applications.all
    else
      @admission_applications = AdmissionApplication.all
    end
    @cohort_id = params[:cohort_id]
    @cohorts = Cohort.all
    respond_with(@admission_applications)
  end

  def show
    respond_with(@admission_application)
  end

  def edit
  end

  def update
    @admission_application.update(admission_application_params)
    respond_with(@admission_application)
  end

  def destroy
    @admission_application.destroy
    respond_with(@admission_application)
  end

  private
    def set_admission_application
      @admission_application = AdmissionApplication.find(params[:id])
    end

    def admission_application_params
      params[:admission_application]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_application_params
      params.require(:admission_application).permit(:first_name, :middle_name, :last_name, :phone, :address, :city, :state, :zip_code, :legal_status, :education, :employment_status, :goal, :income, :linkedin_account, :twitter_account, :github_account, :website_link, :referral_source, :resume_link, :payment_plan, :payment_option, :logic_question_answers_attributes => [:id,:logic_question_id,:answer,:explanation], :profile_question_answers_attributes => [:id,:profil_question_id,:answer,:score], :cohort_ids => [])
    end

end
