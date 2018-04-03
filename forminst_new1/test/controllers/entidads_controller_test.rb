require 'test_helper'

class EntidadsControllerTest < ActionController::TestCase
  setup do
    @entidad = entidads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entidads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entidad" do
    assert_difference('Entidad.count') do
      post :create, entidad: { escuelaId: @entidad.escuelaId, id: @entidad.id, nombre: @entidad.nombre }
    end

    assert_redirected_to entidad_path(assigns(:entidad))
  end

  test "should show entidad" do
    get :show, id: @entidad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entidad
    assert_response :success
  end

  test "should update entidad" do
    patch :update, id: @entidad, entidad: { escuelaId: @entidad.escuelaId, id: @entidad.id, nombre: @entidad.nombre }
    assert_redirected_to entidad_path(assigns(:entidad))
  end

  test "should destroy entidad" do
    assert_difference('Entidad.count', -1) do
      delete :destroy, id: @entidad
    end

    assert_redirected_to entidads_path
  end
end
