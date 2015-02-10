require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  it "should get index" do
    #sign_in users(:user_one)
    get :index
    assert_response :success
  end

end
