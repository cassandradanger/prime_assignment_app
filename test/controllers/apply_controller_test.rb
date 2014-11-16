require 'test_helper'

class ApplyControllerTest < ActionController::TestCase

  # Include authentication test helpers.
  include Devise::TestHelpers                          
  include Warden::Test::Helpers                        
  Warden.test_mode!                                    

  def teardown                                         
    Warden.test_reset!                                 
  end 

  test "should redirect to login when user not logged in" do
  	@request.env["devise.mapping"] = Devise.mappings[:user]
    get :index
    assert_redirected_to user_session_path
  end

  test "should render start when logged in" do
  	@request.env["devise.mapping"] = Devise.mappings[:user]
  	sign_in User.first
    get :index
    assert_redirected_to "/apply/start"
  end


end
