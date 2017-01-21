require 'test_helper'

class DocumentoinformesControllerTest < ActionController::TestCase
  setup do
    @documentoinforme = documentoinformes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documentoinformes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create documentoinforme" do
    assert_difference('Documentoinforme.count') do
      post :create, documentoinforme: { archivo: @documentoinforme.archivo, id: @documentoinforme.id, informeId: @documentoinforme.informeId }
    end

    assert_redirected_to documentoinforme_path(assigns(:documentoinforme))
  end

  test "should show documentoinforme" do
    get :show, id: @documentoinforme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @documentoinforme
    assert_response :success
  end

  test "should update documentoinforme" do
    patch :update, id: @documentoinforme, documentoinforme: { archivo: @documentoinforme.archivo, id: @documentoinforme.id, informeId: @documentoinforme.informeId }
    assert_redirected_to documentoinforme_path(assigns(:documentoinforme))
  end

  test "should destroy documentoinforme" do
    assert_difference('Documentoinforme.count', -1) do
      delete :destroy, id: @documentoinforme
    end

    assert_redirected_to documentoinformes_path
  end
end
