require 'test_helper'

class ObservacionactividadadecuacionsControllerTest < ActionController::TestCase
  setup do
    @observacionactividadadecuacion = observacionactividadadecuacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:observacionactividadadecuacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create observacionactividadadecuacion" do
    assert_difference('Observacionactividadadecuacion.count') do
      post :create, observacionactividadadecuacion: { adecuacionActividadId: @observacionactividadadecuacion.adecuacionActividadId, fecha: @observacionactividadadecuacion.fecha, id: @observacionactividadadecuacion.id, observacion: @observacionactividadadecuacion.observacion, revisionId: @observacionactividadadecuacion.revisionId }
    end

    assert_redirected_to observacionactividadadecuacion_path(assigns(:observacionactividadadecuacion))
  end

  test "should show observacionactividadadecuacion" do
    get :show, id: @observacionactividadadecuacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @observacionactividadadecuacion
    assert_response :success
  end

  test "should update observacionactividadadecuacion" do
    patch :update, id: @observacionactividadadecuacion, observacionactividadadecuacion: { adecuacionActividadId: @observacionactividadadecuacion.adecuacionActividadId, fecha: @observacionactividadadecuacion.fecha, id: @observacionactividadadecuacion.id, observacion: @observacionactividadadecuacion.observacion, revisionId: @observacionactividadadecuacion.revisionId }
    assert_redirected_to observacionactividadadecuacion_path(assigns(:observacionactividadadecuacion))
  end

  test "should destroy observacionactividadadecuacion" do
    assert_difference('Observacionactividadadecuacion.count', -1) do
      delete :destroy, id: @observacionactividadadecuacion
    end

    assert_redirected_to observacionactividadadecuacions_path
  end
end
