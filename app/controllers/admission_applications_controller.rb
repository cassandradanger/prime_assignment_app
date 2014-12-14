class AdmissionApplicationsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_admission_application, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:cohort_id]
      @admission_applications = Cohort.find(params[:cohort_id]).admission_applications.all
    else
      @admission_applications = AdmissionApplication.all
    end
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
end