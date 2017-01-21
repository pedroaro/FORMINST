require 'test_helper'

class ObservacionactividadinformesControllerTest < ActionController::TestCase
  setup do
    @observacionactividadinforme = observacionactividadinformes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:observacionactividadinformes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create observacionactividadinforme" do
    assert_difference('Observacionactividadinforme.count') do
      post :create, observacionactividadinforme: { id: @observacionactividadinforme.id, informeActividadId: @observacionactividadinforme.informeActividadId, observacion: @observacionactividadinforme.observacion, revisionId: @observacionactividadinforme.revisionId }
    end

    assert_redirected_to observacionactividadinforme_path(assigns(:observacionactividadinforme))
  end

  test "should show observacionactividadinforme" do
    get :show, id: @observacionactividadinforme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @observacionactividadinforme
    assert_response :success
  end

  test "should update observacionactividadinforme" do
    patch :update, id: @observacionactividadinforme, observacionactividadinforme: { id: @observacionactividadinforme.id, informeActividadId: @observacionactividadinforme.informeActividadId, observacion: @observacionactividadinforme.observacion, revisionId: @observacionactividadinforme.revisionId }
    assert_redirected_to observacionactividadinforme_path(assigns(:observacionactividadinforme))
  end

  test "should destroy observacionactividadinforme" do
    assert_difference('Observacionactividadinforme.count', -1) do
      delete :destroy, id: @observacionactividadinforme
    end

    assert_redirected_to observacionactividadinformes_path
  end
end
