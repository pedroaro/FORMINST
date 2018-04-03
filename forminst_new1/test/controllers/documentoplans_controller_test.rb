require 'test_helper'

class DocumentoplansControllerTest < ActionController::TestCase
  setup do
    @documentoplan = documentoplans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documentoplans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create documentoplan" do
    assert_difference('Documentoplan.count') do
      post :create, documentoplan: { archivo: @documentoplan.archivo, id: @documentoplan.id, planFormacionId: @documentoplan.planFormacionId }
    end

    assert_redirected_to documentoplan_path(assigns(:documentoplan))
  end

  test "should show documentoplan" do
    get :show, id: @documentoplan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @documentoplan
    assert_response :success
  end

  test "should update documentoplan" do
    patch :update, id: @documentoplan, documentoplan: { archivo: @documentoplan.archivo, id: @documentoplan.id, planFormacionId: @documentoplan.planFormacionId }
    assert_redirected_to documentoplan_path(assigns(:documentoplan))
  end

  test "should destroy documentoplan" do
    assert_difference('Documentoplan.count', -1) do
      delete :destroy, id: @documentoplan
    end

    assert_redirected_to documentoplans_path
  end
end
