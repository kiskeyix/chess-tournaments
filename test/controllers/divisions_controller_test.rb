require 'test_helper'

class DivisionsControllerTest < ActionController::TestCase
  setup do
    @tournament = tournaments(:one)
    @division = @tournament.divisions.first

    sign_in users(:user_three)
    @team = teams(:one)
    @user = users(:user_three)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    get :index, tournament_id: @tournament.id
    assert_response :success
    assert_not_nil assigns(:divisions)
  end

  test "should get new" do
    get :new, tournament_id: @tournament.id
    assert_response :success
  end

  test "should create division" do
    assert_difference('Division.count') do
      post :create, tournament_id: @tournament.id, division: { description: @division.description,
                                image: @division.image, name: @division.name }
    end

    assert_redirected_to division_path(assigns(:division))
  end

  test "should show division" do
    get :show, id: @division
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @division
    assert_response :success
  end

  test "should update division" do
    patch :update, id: @division, division: { description: @division.description, image: @division.image, name: @division.name }
    assert_redirected_to division_path(assigns(:division))
  end

  test "should destroy division" do
    assert_difference('Division.count', -1) do
      delete :destroy, id: @division
    end

    assert_redirected_to tournament_url(@tournament)
  end
end
