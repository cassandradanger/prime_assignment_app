class ProfileQuestionsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_profile_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @profile_questions = ProfileQuestion.all
    respond_with(@profile_questions)
  end

  def show
    respond_with(@profile_question)
  end

  def new
    @profile_question = ProfileQuestion.new
    respond_with(@profile_question)
  end

  def edit
  end

  def create
    @profile_question = ProfileQuestion.new(profile_question_params)
    @profile_question.save
    respond_with(@profile_question)
  end

  def update
    @profile_question.update(profile_question_params)
    respond_with(@profile_question)
  end

  def destroy
    @profile_question.destroy
    respond_with(@profile_question)
  end

  private
    def set_profile_question
      @profile_question = ProfileQuestion.find(params[:id])
    end

    def profile_question_params
      params.require(:profile_question).permit(:question, :published, :scoring_guideline_1, :scoring_guideline_2, :scoring_guideline_3, :scoring_guideline_4, :scoring_guideline_5)
    end
end
