require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  before do 
    OmniAuth.config.test_mode = true
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
  end
  it "should get index" do
    #sign_in users(:user_one)
    get :index
    assert_response :success
  end

end
