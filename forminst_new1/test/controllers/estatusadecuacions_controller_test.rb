require 'test_helper'

class EstatusadecuacionsControllerTest < ActionController::TestCase
  setup do
    @estatusadecuacion = estatusadecuacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estatusadecuacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estatusadecuacion" do
    assert_difference('Estatusadecuacion.count') do
      post :create, estatusadecuacion: { actual: @estatusadecuacion.actual, adecuacionId: @estatusadecuacion.adecuacionId, estatusId: @estatusadecuacion.estatusId, fecha: @estatusadecuacion.fecha, id: @estatusadecuacion.id }
    end

    assert_redirected_to estatusadecuacion_path(assigns(:estatusadecuacion))
  end

  test "should show estatusadecuacion" do
    get :show, id: @estatusadecuacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estatusadecuacion
    assert_response :success
  end

  test "should update estatusadecuacion" do
    patch :update, id: @estatusadecuacion, estatusadecuacion: { actual: @estatusadecuacion.actual, adecuacionId: @estatusadecuacion.adecuacionId, estatusId: @estatusadecuacion.estatusId, fecha: @estatusadecuacion.fecha, id: @estatusadecuacion.id }
    assert_redirected_to estatusadecuacion_path(assigns(:estatusadecuacion))
  end

  test "should destroy estatusadecuacion" do
    assert_difference('Estatusadecuacion.count', -1) do
      delete :destroy, id: @estatusadecuacion
    end

    assert_redirected_to estatusadecuacions_path
  end
end
