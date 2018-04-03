require 'test_helper'

class ActividadejecutadasControllerTest < ActionController::TestCase
  setup do
    @actividadejecutada = actividadejecutadas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:actividadejecutadas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create actividadejecutada" do
    assert_difference('Actividadejecutada.count') do
      post :create, actividadejecutada: { actual: @actividadejecutada.actual, descripcion: @actividadejecutada.descripcion, fecha: @actividadejecutada.fecha, id: @actividadejecutada.id, informeActividadId: @actividadejecutada.informeActividadId }
    end

    assert_redirected_to actividadejecutada_path(assigns(:actividadejecutada))
  end

  test "should show actividadejecutada" do
    get :show, id: @actividadejecutada
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @actividadejecutada
    assert_response :success
  end

  test "should update actividadejecutada" do
    patch :update, id: @actividadejecutada, actividadejecutada: { actual: @actividadejecutada.actual, descripcion: @actividadejecutada.descripcion, fecha: @actividadejecutada.fecha, id: @actividadejecutada.id, informeActividadId: @actividadejecutada.informeActividadId }
    assert_redirected_to actividadejecutada_path(assigns(:actividadejecutada))
  end

  test "should destroy actividadejecutada" do
    assert_difference('Actividadejecutada.count', -1) do
      delete :destroy, id: @actividadejecutada
    end

    assert_redirected_to actividadejecutadas_path
  end
end
