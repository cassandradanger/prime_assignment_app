class LogicQuestionsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_logic_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @logic_questions = LogicQuestion.all
    respond_with(@logic_questions)
  end

  def show
    respond_with(@logic_question)
  end

  def new
    @logic_question = LogicQuestion.new
    respond_with(@logic_question)
  end

  def edit
  end

  def create
    @logic_question = LogicQuestion.new(logic_question_params)
    @logic_question.save
    respond_with(@logic_question)
  end

  def update
    @logic_question.update(logic_question_params)
    respond_with(@logic_question)
  end

  def destroy
    @logic_question.destroy
    respond_with(@logic_question)
  end

  private
    def set_logic_question
      @logic_question = LogicQuestion.find(params[:id])
    end

    def logic_question_params
      params.require(:logic_question).permit(:question, :solution, :status, :question_image)
    end
end
