require 'test_helper'

class RoundsControllerTest < ActionController::TestCase
  setup do
    @round = rounds(:one)
    @tournament = tournaments(:one)

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    get :index, tournament_id: @tournament.id
    assert_response :success
    assert_not_nil assigns(:rounds)
  end

  test "should get new" do
    sign_in users(:user_three)
    get :new, tournament_id: @tournament.id
    assert_response :success
  end

  test "should create round" do
    sign_in users(:user_three)
    assert_difference('Round.count') do
      post :create, tournament_id: @tournament.id,
        round: { description: @round.description, end_date: @round.end_date,
                 name: @round.name + "new", start_date: @round.start_date,
                 tournament_id: @round.tournament_id }
    end

    assert_redirected_to round_path(assigns(:round))
  end

  it "should fail to create round" do
    sign_in users(:user_three)
    assert_difference('Round.count', 0) do
      post :create, tournament_id: @tournament.id,
        round: { description: @round.description, end_date: @round.end_date,
                 name: @round.name + "new", start_date: @round.start_date - 1.year,
                 tournament_id: @round.tournament_id }
    end

    assert_response :success
  end

  test "should show round" do
    get :show, id: @round
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:user_three)
    get :edit, id: @round
    assert_response :success
  end

  test "should update round" do
    sign_in users(:user_three)
    patch :update, id: @round, round: { description: @round.description,
                                        end_date: @round.end_date,
                                        name: @round.name + "updated",
                                        start_date: @round.start_date,
                                        tournament_id: @round.tournament_id }
    assert_redirected_to round_path(assigns(:round))
  end

  it "should fail to update round" do
    sign_in users(:user_three)
    patch :update, id: @round, round: { description: @round.description,
                                        end_date: @round.end_date - 1.year,
                                        name: @round.name + "updated",
                                        start_date: @round.start_date,
                                        tournament_id: @round.tournament_id }
    assert_response :success # goes back to :edit
  end


  test "should destroy round" do
    sign_in users(:user_three)
    assert_difference('Round.count', -1) do
      delete :destroy, id: @round
    end

    assert_redirected_to tournament_rounds_path(tournament_id: @tournament.id)
  end
end
