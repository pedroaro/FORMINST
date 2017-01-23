require 'test_helper'

class TipoactividadsControllerTest < ActionController::TestCase
  setup do
    @tipoactividad = tipoactividads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipoactividads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipoactividad" do
    assert_difference('Tipoactividad.count') do
      post :create, tipoactividad: { concepto: @tipoactividad.concepto, grupoActividadesId: @tipoactividad.grupoActividadesId, id: @tipoactividad.id, subGrupoActividadId: @tipoactividad.subGrupoActividadId }
    end

    assert_redirected_to tipoactividad_path(assigns(:tipoactividad))
  end

  test "should show tipoactividad" do
    get :show, id: @tipoactividad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipoactividad
    assert_response :success
  end

  test "should update tipoactividad" do
    patch :update, id: @tipoactividad, tipoactividad: { concepto: @tipoactividad.concepto, grupoActividadesId: @tipoactividad.grupoActividadesId, id: @tipoactividad.id, subGrupoActividadId: @tipoactividad.subGrupoActividadId }
    assert_redirected_to tipoactividad_path(assigns(:tipoactividad))
  end

  test "should destroy tipoactividad" do
    assert_difference('Tipoactividad.count', -1) do
      delete :destroy, id: @tipoactividad
    end

    assert_redirected_to tipoactividads_path
  end
end
