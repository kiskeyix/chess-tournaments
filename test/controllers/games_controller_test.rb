require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
    @player_one = players(:one)
    @player_two = players(:two)

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new, player_id: @player_two.id
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, player_id: @player_one.id, game: { black_elo: @game.black_elo, date: @game.date,
                            division_id: @game.division_id, event: @game.event,
                            fen: @game.fen, name: @game.name + "new", pgn: @game.pgn,
                            result: @game.result, site: @game.site,
                            timecontrol: @game.timecontrol, white_elo: @game.white_elo }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game, player_id: @player_one
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    patch :update, id: @game, game: { black_elo: @game.black_elo,
                                      date: @game.date, division_id: @game.division_id,
                                      event: @game.event, fen: @game.fen,
                                      name: @game.name + "new", pgn: @game.pgn,
                                      result: @game.result, site: @game.site,
                                      timecontrol: @game.timecontrol,
                                      white_elo: @game.white_elo }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
