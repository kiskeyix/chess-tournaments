require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { black_elo: @game.black_elo, date: @game.date, division_id: @game.division_id, event: @game.event, fen: @game.fen, name: @game.name, pgn: @game.pgn, result: @game.result, site: @game.site, timecontrol: @game.timecontrol, while_elo: @game.while_elo }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    patch :update, id: @game, game: { black_elo: @game.black_elo, date: @game.date, division_id: @game.division_id, event: @game.event, fen: @game.fen, name: @game.name, pgn: @game.pgn, result: @game.result, site: @game.site, timecontrol: @game.timecontrol, while_elo: @game.while_elo }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
