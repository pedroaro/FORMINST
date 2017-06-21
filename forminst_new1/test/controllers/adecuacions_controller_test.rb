require 'test_helper'

class AdecuacionsControllerTest < ActionController::TestCase
  setup do
    @adecuacion = adecuacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adecuacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adecuacion" do
    assert_difference('Adecuacion.count') do
      post :create, adecuacion: { PlanFormacionId: @adecuacion.PlanFormacionId, id: @adecuacion.id, tutorId: @adecuacion.tutorId }
    end

    assert_redirected_to adecuacion_path(assigns(:adecuacion))
  end

  test "should show adecuacion" do
    get :show, id: @adecuacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adecuacion
    assert_response :success
  end

  test "should update adecuacion" do
    patch :update, id: @adecuacion, adecuacion: { PlanFormacionId: @adecuacion.PlanFormacionId, id: @adecuacion.id, tutorId: @adecuacion.tutorId }
    assert_redirected_to adecuacion_path(assigns(:adecuacion))
  end

  test "should destroy adecuacion" do
    assert_difference('Adecuacion.count', -1) do
      delete :destroy, id: @adecuacion
    end

    assert_redirected_to adecuacions_path
  end
end
