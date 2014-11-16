require 'test_helper'

class LogicQuestionsControllerTest < ActionController::TestCase
  setup do
    @logic_question = logic_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logic_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logic_question" do
    assert_difference('LogicQuestion.count') do
      post :create, logic_question: { question: @logic_question.question, solution: @logic_question.solution, status: @logic_question.status }
    end

    assert_redirected_to logic_question_path(assigns(:logic_question))
  end

  test "should show logic_question" do
    get :show, id: @logic_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logic_question
    assert_response :success
  end

  test "should update logic_question" do
    patch :update, id: @logic_question, logic_question: { question: @logic_question.question, solution: @logic_question.solution, status: @logic_question.status }
    assert_redirected_to logic_question_path(assigns(:logic_question))
  end

  test "should destroy logic_question" do
    assert_difference('LogicQuestion.count', -1) do
      delete :destroy, id: @logic_question
    end

    assert_redirected_to logic_questions_path
  end
end
