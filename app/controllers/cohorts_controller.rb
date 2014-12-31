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

  private
    def set_cohort
      @cohort = Cohort.find(params[:id])
    end

    def cohort_params
      params.require(:cohort).permit(:name, :prework_start, :classroom_start, :graduation, :applications_open, :applications_close)
    end
end
