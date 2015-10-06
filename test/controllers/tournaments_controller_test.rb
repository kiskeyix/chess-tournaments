require 'test_helper'

class TournamentsControllerTest < ActionController::TestCase
  setup do
    @tournament = tournaments(:one)

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    assert_routing({ path: 'tournaments', method: :get },
                   { controller: 'tournaments', action: 'index' })
    get :index
    assert_response :success
    assert_not_nil assigns(:tournaments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tournament" do
    assert_difference('Tournament.count') do
      post :create, tournament: { description: @tournament.description,
                                  image: @tournament.image, name: @tournament.name + " new" }
    end

    assert_redirected_to tournament_path(assigns(:tournament))
  end

  test "should show tournament" do
    assert_routing({ path: 'tournaments/1', method: :get },
                   { controller: 'tournaments', action: 'show', id: '1' })

    get :show, id: @tournament
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tournament
    assert_response :success
  end

  test "should update tournament" do
    patch :update, id: @tournament, tournament: { description: @tournament.description, image: @tournament.image, name: @tournament.name }
    assert_redirected_to tournament_path(assigns(:tournament))
  end

  test "should destroy tournament" do
    assert_difference('Tournament.count', -1) do
      delete :destroy, id: @tournament
    end

    assert_redirected_to tournaments_path
  end
end
