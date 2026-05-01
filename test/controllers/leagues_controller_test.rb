require 'test_helper'

class LeaguesControllerTest < ActionController::TestCase
  setup do
    @league = leagues(:one)

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leagues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create league" do
    assert_difference('League.count') do
      post :create, params: { league: { description: @league.description,
                              image: @league.image, name: @league.name + " new" } }
    end

    assert_redirected_to league_path(assigns(:league))
  end

  test "should show league" do
    get :show, params: { id: @league }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @league }
    assert_response :success
  end

  test "should update league" do
    patch :update, params: { id: @league, league: { description: @league.description, image: @league.image, name: @league.name } }
    assert_redirected_to league_path(assigns(:league))
  end

  test "should destroy league" do
    assert_difference('League.count', -1) do
      delete :destroy, params: { id: @league }
    end

    assert_redirected_to leagues_path
  end
end
