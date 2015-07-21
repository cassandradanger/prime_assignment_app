class LogicQuestionsController < AdminApplicationController
  before_action :set_logic_question, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  respond_to :html

  def show
    respond_with(@logic_question)
  end

  def new
    @logic_question = LogicQuestion.new
    @logic_question.course = @course
    respond_with(@logic_question)
  end

  def edit
  end

  def create
    @logic_question = LogicQuestion.new(logic_question_params)
    @logic_question.course = @course
    @logic_question.save
    respond_with(@course)
  end

  def update
    @logic_question.update(logic_question_params)
    respond_with(@course)
  end

  def destroy
    @logic_question.active = false
    @logic_question.save
    respond_with(@course)
  end

  private
  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_logic_question
    @logic_question = LogicQuestion.find(params[:id])
  end

  def logic_question_params
    params.require(:logic_question).permit(:question, :solution, :published, :question_image, :position)
  end
end
