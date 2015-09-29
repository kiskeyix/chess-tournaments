require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  before do 
    OmniAuth.config.test_mode = true
    # pretend to sign with twitter
    OmniAuth.config.mock_auth[:twitter] = {
      'uid' => 101112,
      "extra" => {
        "user_hash" => {
          "email" => 'change@me-101112-twitter.com',
          "name" => 'first-name middle-name last-name sur-name',
          "username" => 'uid_101112',
          #"last_name" => 'last-name',
#           "gender" => user_hash[:gender]
        }
      }
    }
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
  end
  it "should get index" do
    #sign_in users(:user_one)
    get :index
    assert_response :success
  end
  it "should get index after sign in" do
    sign_in users(:user_one)
    get :index
    assert_response :success
  end
end
