require 'test_helper'

class InjuriesControllerTest < ActionController::TestCase
  setup do
    @injury = injuries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:injuries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create injury" do
    assert_difference('Injury.count') do
      post :create, injury: @injury.attributes
    end

    assert_redirected_to injury_path(assigns(:injury))
  end

  test "should show injury" do
    get :show, id: @injury
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @injury
    assert_response :success
  end

  test "should update injury" do
    put :update, id: @injury, injury: @injury.attributes
    assert_redirected_to injury_path(assigns(:injury))
  end

  test "should destroy injury" do
    assert_difference('Injury.count', -1) do
      delete :destroy, id: @injury
    end

    assert_redirected_to injuries_path
  end
end
