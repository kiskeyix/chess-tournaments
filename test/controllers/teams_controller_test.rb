require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    #p users(:user_three)

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    sign_in users(:user_three)
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should get new" do
    sign_in users(:user_three)
    get :new
    assert_response :success
  end

  test "should create team" do
    sign_in users(:user_three)
    assert_difference('Team.count') do
      post :create, team: { name: "bar" }
    end

    assert_redirected_to team_path(assigns(:team))
  end

  test "should show team" do
    #sign_in users(:user_three)
    get :show, id: @team
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:user_three)
    get :edit, id: @team
    assert_response :success
  end

  test "should update team" do
    sign_in users(:user_three)

    @team.captains.include?(@user.player).must_equal true

    patch :update, id: @team, team: { name: "foo" }
    assert_redirected_to team_path(assigns(:team))
  end

  it "should destroy team if there is no results and your user is captain" do
    #sign_in users(:user_three)
    #assert_difference('Team.count', -1) do
    #  delete :destroy, id: @team
    #end
    #assert_redirected_to teams_path
  end
end
