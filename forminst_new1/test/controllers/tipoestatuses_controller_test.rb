require 'test_helper'

class TipoestatusesControllerTest < ActionController::TestCase
  setup do
    @tipoestatus = tipoestatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipoestatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipoestatus" do
    assert_difference('Tipoestatus.count') do
      post :create, tipoestatus: { id: @tipoestatus.id, informeId: @tipoestatus.informeId }
    end

    assert_redirected_to tipoestatus_path(assigns(:tipoestatus))
  end

  test "should show tipoestatus" do
    get :show, id: @tipoestatus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipoestatus
    assert_response :success
  end

  test "should update tipoestatus" do
    patch :update, id: @tipoestatus, tipoestatus: { id: @tipoestatus.id, informeId: @tipoestatus.informeId }
    assert_redirected_to tipoestatus_path(assigns(:tipoestatus))
  end

  test "should destroy tipoestatus" do
    assert_difference('Tipoestatus.count', -1) do
      delete :destroy, id: @tipoestatus
    end

    assert_redirected_to tipoestatuses_path
  end
end
