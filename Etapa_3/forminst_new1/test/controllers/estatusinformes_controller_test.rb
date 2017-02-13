require 'test_helper'

class EstatusinformesControllerTest < ActionController::TestCase
  setup do
    @estatusinforme = estatusinformes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estatusinformes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estatusinforme" do
    assert_difference('Estatusinforme.count') do
      post :create, estatusinforme: { actual: @estatusinforme.actual, estatusId: @estatusinforme.estatusId, fecha: @estatusinforme.fecha, id: @estatusinforme.id, informeId: @estatusinforme.informeId }
    end

    assert_redirected_to estatusinforme_path(assigns(:estatusinforme))
  end

  test "should show estatusinforme" do
    get :show, id: @estatusinforme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estatusinforme
    assert_response :success
  end

  test "should update estatusinforme" do
    patch :update, id: @estatusinforme, estatusinforme: { actual: @estatusinforme.actual, estatusId: @estatusinforme.estatusId, fecha: @estatusinforme.fecha, id: @estatusinforme.id, informeId: @estatusinforme.informeId }
    assert_redirected_to estatusinforme_path(assigns(:estatusinforme))
  end

  test "should destroy estatusinforme" do
    assert_difference('Estatusinforme.count', -1) do
      delete :destroy, id: @estatusinforme
    end

    assert_redirected_to estatusinformes_path
  end
end
