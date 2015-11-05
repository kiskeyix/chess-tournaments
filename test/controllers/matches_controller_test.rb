require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  setup do
    @match = matches(:one)

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create match" do
    assert_difference('Match.count') do
      post :create, match: { description: @match.description, guest_team_id: @match.guest_team_id, guest_team_lineup_id: @match.guest_team_lineup_id, home_team_id: @match.home_team_id, home_team_lineup_id: @match.home_team_lineup_id, location: @match.location, name: @match.name, postponed_date: @match.postponed_date, result_id: @match.result_id, round_id: @match.round_id }
    end

    assert_redirected_to match_path(assigns(:match))
  end

  test "should show match" do
    get :show, id: @match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @match
    assert_response :success
  end

  test "should update match" do
    patch :update, id: @match, match: { description: @match.description, guest_team_id: @match.guest_team_id, guest_team_lineup_id: @match.guest_team_lineup_id, home_team_id: @match.home_team_id, home_team_lineup_id: @match.home_team_lineup_id, location: @match.location, name: @match.name, postponed_date: @match.postponed_date, result_id: @match.result_id, round_id: @match.round_id }
    assert_redirected_to match_path(assigns(:match))
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete :destroy, id: @match
    end

    assert_redirected_to matches_path
  end
end
