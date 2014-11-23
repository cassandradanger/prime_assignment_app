class ApplyController < ApplicationController
	
	before_action :authenticate_user!, :set_admission_application

	# Setup application wizard support.
	include Wicked::Wizard
	steps :start, :general, :personal, :logic, :technical, :submit

  	# GET /apply/{step}
	def show
		if @admission_application.application_status == "complete" && step != :start
			redirect_to wizard_path(:start)
		else
			if step == :general
				@cohorts = Cohort.current
			elsif step == :submit
				@admission_application.application_step = "active"
				@admission_application.valid?
			end
			render_wizard
		end
	end

  # PATCH/PUT /apply/{step}
  def update
    respond_to do |format|
      	params[:admission_application][:application_step] = step.to_s
		if step == steps.last
			@admission_application.populate_questions
			params[:admission_application][:application_step] = 'active'
			params[:admission_application][:application_status] = 'complete'
			params[:admission_application][:completed_at] = Time.now
		end
		if @admission_application.update(admission_application_params)
			format.html { redirect_to next_wizard_path }
		else
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_application_params
      params.require(:admission_application).permit(:first_name, :last_name, :application_status, :application_step, :logic_question_answers_attributes => [:id,:logic_question_id,:answer,:explanation], :profile_question_answers_attributes => [:id,:profil_question_id,:answer], :cohort_ids => [])
    end

	def finish_wizard_path
	  wizard_path(:start)
	end    

end
