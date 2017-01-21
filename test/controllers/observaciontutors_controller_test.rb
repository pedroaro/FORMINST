require 'test_helper'

class ObservaciontutorsControllerTest < ActionController::TestCase
  setup do
    @observaciontutor = observaciontutors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:observaciontutors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create observaciontutor" do
    assert_difference('Observaciontutor.count') do
      post :create, observaciontutor: { actual: @observaciontutor.actual, fecha: @observaciontutor.fecha, id: @observaciontutor.id, informeActividadId: @observaciontutor.informeActividadId, observacion: @observaciontutor.observacion }
    end

    assert_redirected_to observaciontutor_path(assigns(:observaciontutor))
  end

  test "should show observaciontutor" do
    get :show, id: @observaciontutor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @observaciontutor
    assert_response :success
  end

  test "should update observaciontutor" do
    patch :update, id: @observaciontutor, observaciontutor: { actual: @observaciontutor.actual, fecha: @observaciontutor.fecha, id: @observaciontutor.id, informeActividadId: @observaciontutor.informeActividadId, observacion: @observaciontutor.observacion }
    assert_redirected_to observaciontutor_path(assigns(:observaciontutor))
  end

  test "should destroy observaciontutor" do
    assert_difference('Observaciontutor.count', -1) do
      delete :destroy, id: @observaciontutor
    end

    assert_redirected_to observaciontutors_path
  end
end
