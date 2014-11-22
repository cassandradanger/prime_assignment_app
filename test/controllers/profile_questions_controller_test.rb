require 'test_helper'

class ProfileQuestionsControllerTest < ActionController::TestCase
  setup do
    @profile_question = profile_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_question" do
    assert_difference('ProfileQuestion.count') do
      post :create, profile_question: { published: @profile_question.published, question: @profile_question.question, scoring_guideline_1: @profile_question.scoring_guideline_1, scoring_guideline_2: @profile_question.scoring_guideline_2, scoring_guideline_3: @profile_question.scoring_guideline_3, scoring_guideline_4: @profile_question.scoring_guideline_4, scoring_guideline_5: @profile_question.scoring_guideline_5 }
    end

    assert_redirected_to profile_question_path(assigns(:profile_question))
  end

  test "should show profile_question" do
    get :show, id: @profile_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_question
    assert_response :success
  end

  test "should update profile_question" do
    patch :update, id: @profile_question, profile_question: { published: @profile_question.published, question: @profile_question.question, scoring_guideline_1: @profile_question.scoring_guideline_1, scoring_guideline_2: @profile_question.scoring_guideline_2, scoring_guideline_3: @profile_question.scoring_guideline_3, scoring_guideline_4: @profile_question.scoring_guideline_4, scoring_guideline_5: @profile_question.scoring_guideline_5 }
    assert_redirected_to profile_question_path(assigns(:profile_question))
  end

  test "should destroy profile_question" do
    assert_difference('ProfileQuestion.count', -1) do
      delete :destroy, id: @profile_question
    end

    assert_redirected_to profile_questions_path
  end
end
