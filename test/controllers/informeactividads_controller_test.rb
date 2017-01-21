require 'test_helper'

class InformeactividadsControllerTest < ActionController::TestCase
  setup do
    @informeactividad = informeactividads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:informeactividads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create informeactividad" do
    assert_difference('Informeactividad.count') do
      post :create, informeactividad: { actividadId: @informeactividad.actividadId, id: @informeactividad.id, informeId: @informeactividad.informeId }
    end

    assert_redirected_to informeactividad_path(assigns(:informeactividad))
  end

  test "should show informeactividad" do
    get :show, id: @informeactividad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @informeactividad
    assert_response :success
  end

  test "should update informeactividad" do
    patch :update, id: @informeactividad, informeactividad: { actividadId: @informeactividad.actividadId, id: @informeactividad.id, informeId: @informeactividad.informeId }
    assert_redirected_to informeactividad_path(assigns(:informeactividad))
  end

  test "should destroy informeactividad" do
    assert_difference('Informeactividad.count', -1) do
      delete :destroy, id: @informeactividad
    end

    assert_redirected_to informeactividads_path
  end
end
