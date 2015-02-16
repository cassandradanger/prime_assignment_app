class ApplyController < ApplicationController

	# Setup application wizard support.
	include Wicked::Wizard
	steps :start, :general, :personal, :logic, :technical, :submit, :thanks
	
	before_action :authenticate_user!, :set_admission_application, :redirect_completed_applicants

	# GET /apply/{step}
	def show
		case step
			when :general
				@cohorts = Cohort.current
			when :submit
				# trigger final validation
				@admission_application.application_step = step.to_s
				@admission_application.valid?
		end
		render_wizard
	end

	# PATCH/PUT /apply/{step}
	def update
		respond_to do |format|
		  	@admission_application.application_step = step.to_s
			if @admission_application.update(admission_application_params)
				format.html { redirect_to next_wizard_path }
			else
				flash.now[:error] = 'There was a problem with your submission, your changes have not yet been saved. Please make corrections and resubmit.'
				format.html { render_wizard }
			end
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admission_application
    	@user = current_user
    	@admission_application = @user.admission_application || @user.create_admission_application()
    end

    def redirect_completed_applicants
		redirect_to wizard_path(:thanks) if @admission_application.completed? && step != :thanks
    end

	def finish_wizard_path
	  wizard_path(:start)
	end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_application_params
      params.require(:admission_application).permit(:first_name, :middle_name, :last_name, :phone, :address,
                                                    :city, :state, :zip_code, :legal_status, :education,
                                                    :employment_status, :goal, :income, :linkedin_account,
                                                    :twitter_account, :github_account, :website_link,
                                                    :referral_source, :resume_link, :payment_plan,
                                                    :payment_option, :gender, :birthdate, :dependents,
                                                    :geography, :veteran, :race_hispanic, :race_nativeamerican,
                                                    :race_asian, :race_black, :race_islander, :race_white,
                                                    :race_other,
                                                    :logic_question_answers_attributes => [:id,:logic_question_id,:answer,:explanation],
                                                    :profile_question_answers_attributes => [:id,:profil_question_id,:answer],
                                                    :cohort_ids => [])
    end

end
