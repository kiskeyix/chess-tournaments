require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
    @player_one = players(:one)
    @player_two = players(:two)
    @player_three = players(:three)

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
    sign_in users(:user_three)
    get :new, player_id: @player_two.id
    assert_response :success
  end

  test "should create game" do
    sign_in users(:user_three)
    assert_difference('Game.count') do
      post :create, player_id: @player_one.id, game: {
        black_elo: @game.black_elo, date: @game.date,
        black_player_id: @player_three.id, white_player_id: @player_one.id,
        division_id: @game.division_id, event: @game.event,
        fen: @game.fen, name: @game.name + "new", pgn: @game.pgn,
        result: @game.result, site: @game.site,
        timecontrol: @game.timecontrol, white_elo: @game.white_elo }
    end

    # redirected to current_user.player, game
    assert_redirected_to player_game_path(@player_three,assigns(:game))
  end

  test "should show game" do
    get :show, id: @game, player_id: @player_one
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:user_three)
    get :edit, player_id: @player_one.id, id: @game
    assert_response :success
  end

  test "should update game" do
    sign_in users(:user_three)
    patch :update, player_id: @player_three.id, id: @game, game: { black_elo: @game.black_elo,
                                      date: @game.date, division_id: @game.division_id,
                                      event: @game.event, fen: @game.fen,
                                      name: @game.name + "new", pgn: @game.pgn,
                                      result: @game.result, site: @game.site,
                                      timecontrol: @game.timecontrol,
                                      white_elo: @game.white_elo }
    assert_redirected_to player_game_path(@player_three.id,assigns(:game))
  end

  test "should destroy game" do
    sign_in users(:user_one)
    assert_difference('Game.count', -1) do
      delete :destroy, player_id: @player_one.id, id: @game
    end

    assert_redirected_to games_path
  end
end
