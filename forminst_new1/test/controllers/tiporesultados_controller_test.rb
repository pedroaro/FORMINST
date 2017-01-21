require 'test_helper'

class TiporesultadosControllerTest < ActionController::TestCase
  setup do
    @tiporesultado = tiporesultados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tiporesultados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tiporesultado" do
    assert_difference('Tiporesultado.count') do
      post :create, tiporesultado: { concepto: @tiporesultado.concepto, id: @tiporesultado.id, idPadre: @tiporesultado.idPadre, tipoActividadId: @tiporesultado.tipoActividadId }
    end

    assert_redirected_to tiporesultado_path(assigns(:tiporesultado))
  end

  test "should show tiporesultado" do
    get :show, id: @tiporesultado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tiporesultado
    assert_response :success
  end

  test "should update tiporesultado" do
    patch :update, id: @tiporesultado, tiporesultado: { concepto: @tiporesultado.concepto, id: @tiporesultado.id, idPadre: @tiporesultado.idPadre, tipoActividadId: @tiporesultado.tipoActividadId }
    assert_redirected_to tiporesultado_path(assigns(:tiporesultado))
  end

  test "should destroy tiporesultado" do
    assert_difference('Tiporesultado.count', -1) do
      delete :destroy, id: @tiporesultado
    end

    assert_redirected_to tiporesultados_path
  end
end
