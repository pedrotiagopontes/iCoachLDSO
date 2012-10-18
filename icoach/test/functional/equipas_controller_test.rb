require 'test_helper'

class EquipasControllerTest < ActionController::TestCase
  setup do
    @equipa = equipas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:equipas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipa" do
    assert_difference('Equipa.count') do
      post :create, equipa: @equipa.attributes
    end

    assert_redirected_to equipa_path(assigns(:equipa))
  end

  test "should show equipa" do
    get :show, id: @equipa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipa
    assert_response :success
  end

  test "should update equipa" do
    put :update, id: @equipa, equipa: @equipa.attributes
    assert_redirected_to equipa_path(assigns(:equipa))
  end

  test "should destroy equipa" do
    assert_difference('Equipa.count', -1) do
      delete :destroy, id: @equipa
    end

    assert_redirected_to equipas_path
  end
end
