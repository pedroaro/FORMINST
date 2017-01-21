require 'test_helper'

class UsuarioentidadsControllerTest < ActionController::TestCase
  setup do
    @usuarioentidad = usuarioentidads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usuarioentidads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usuarioentidad" do
    assert_difference('Usuarioentidad.count') do
      post :create, usuarioentidad: { entidadesId: @usuarioentidad.entidadesId, id: @usuarioentidad.id, usuarioId: @usuarioentidad.usuarioId }
    end

    assert_redirected_to usuarioentidad_path(assigns(:usuarioentidad))
  end

  test "should show usuarioentidad" do
    get :show, id: @usuarioentidad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usuarioentidad
    assert_response :success
  end

  test "should update usuarioentidad" do
    patch :update, id: @usuarioentidad, usuarioentidad: { entidadesId: @usuarioentidad.entidadesId, id: @usuarioentidad.id, usuarioId: @usuarioentidad.usuarioId }
    assert_redirected_to usuarioentidad_path(assigns(:usuarioentidad))
  end

  test "should destroy usuarioentidad" do
    assert_difference('Usuarioentidad.count', -1) do
      delete :destroy, id: @usuarioentidad
    end

    assert_redirected_to usuarioentidads_path
  end
end
