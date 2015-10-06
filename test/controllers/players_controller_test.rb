require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, player: { gender: @player.gender,
                              image: @player.image, name: @player.name + "2",
                              nationality: @player.nationality }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player
    assert_response :success
  end

  test "should update player" do
    patch :update, id: @player, player: { gender: @player.gender, image: @player.image,
                                          name: @player.name, nationality: @player.nationality,
                                          user_id: @player.user_id }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should not destroy player unless admin" do
    @user.admin?.must_equal true
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_redirected_to players_path

    sign_out users(:user_three)

    assert_difference('Player.count', 0) do
      delete :destroy, id: @player
    end
    assert_redirected_to new_user_session_path
  end
end
