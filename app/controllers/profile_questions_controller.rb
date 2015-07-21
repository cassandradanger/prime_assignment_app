class ProfileQuestionsController < AdminApplicationController
  before_action :set_profile_question, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  respond_to :html

  def show
    respond_with(@profile_question)
  end

  def new
    @profile_question = ProfileQuestion.new
    @profile_question.course = @course
    respond_with(@profile_question)
  end

  def edit
  end

  def create
    @profile_question = ProfileQuestion.new(profile_question_params)
    @profile_question.course = @course
    @profile_question.save
    respond_with(@course)
  end

  def update
    @profile_question.update(profile_question_params)
    respond_with(@course)
  end

  def destroy
    @profile_question.active = false
    @profile_question.save
    respond_with(@course)
  end

  private
  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_profile_question
    @profile_question = ProfileQuestion.find(params[:id])
  end

  def profile_question_params
    params.require(:profile_question).permit(:question, :published, :position, :scoring_guideline_1, :scoring_guideline_2, :scoring_guideline_3, :scoring_guideline_4, :scoring_guideline_5)
  end
end
