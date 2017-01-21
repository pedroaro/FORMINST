require 'test_helper'

class PlanformacionsControllerTest < ActionController::TestCase
  setup do
    @planformacion = planformacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planformacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planformacion" do
    assert_difference('Planformacion.count') do
      post :create, planformacion: { activo: @planformacion.activo, fechaFin: @planformacion.fechaFin, fechaInicio: @planformacion.fechaInicio, id: @planformacion.id, instructorId: @planformacion.instructorId, tutorId: @planformacion.tutorId }
    end

    assert_redirected_to planformacion_path(assigns(:planformacion))
  end

  test "should show planformacion" do
    get :show, id: @planformacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @planformacion
    assert_response :success
  end

  test "should update planformacion" do
    patch :update, id: @planformacion, planformacion: { activo: @planformacion.activo, fechaFin: @planformacion.fechaFin, fechaInicio: @planformacion.fechaInicio, id: @planformacion.id, instructorId: @planformacion.instructorId, tutorId: @planformacion.tutorId }
    assert_redirected_to planformacion_path(assigns(:planformacion))
  end

  test "should destroy planformacion" do
    assert_difference('Planformacion.count', -1) do
      delete :destroy, id: @planformacion
    end

    assert_redirected_to planformacions_path
  end
end
