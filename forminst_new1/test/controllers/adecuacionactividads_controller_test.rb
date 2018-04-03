require 'test_helper'

class AdecuacionactividadsControllerTest < ActionController::TestCase
  setup do
    @adecuacionactividad = adecuacionactividads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adecuacionactividads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adecuacionactividad" do
    assert_difference('Adecuacionactividad.count') do
      post :create, adecuacionactividad: { actividadId: @adecuacionactividad.actividadId, adecuacionId: @adecuacionactividad.adecuacionId, anulada: @adecuacionactividad.anulada, id: @adecuacionactividad.id, semestre: @adecuacionactividad.semestre }
    end

    assert_redirected_to adecuacionactividad_path(assigns(:adecuacionactividad))
  end

  test "should show adecuacionactividad" do
    get :show, id: @adecuacionactividad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adecuacionactividad
    assert_response :success
  end

  test "should update adecuacionactividad" do
    patch :update, id: @adecuacionactividad, adecuacionactividad: { actividadId: @adecuacionactividad.actividadId, adecuacionId: @adecuacionactividad.adecuacionId, anulada: @adecuacionactividad.anulada, id: @adecuacionactividad.id, semestre: @adecuacionactividad.semestre }
    assert_redirected_to adecuacionactividad_path(assigns(:adecuacionactividad))
  end

  test "should destroy adecuacionactividad" do
    assert_difference('Adecuacionactividad.count', -1) do
      delete :destroy, id: @adecuacionactividad
    end

    assert_redirected_to adecuacionactividads_path
  end
end
