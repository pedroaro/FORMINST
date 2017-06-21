require 'test_helper'

class ProrrogasControllerTest < ActionController::TestCase
  setup do
    @prorroga = prorrogas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prorrogas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prorroga" do
    assert_difference('Prorroga.count') do
      post :create, prorroga: { id: @prorroga.id, planFormacionId: @prorroga.planFormacionId }
    end

    assert_redirected_to prorroga_path(assigns(:prorroga))
  end

  test "should show prorroga" do
    get :show, id: @prorroga
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prorroga
    assert_response :success
  end

  test "should update prorroga" do
    patch :update, id: @prorroga, prorroga: { id: @prorroga.id, planFormacionId: @prorroga.planFormacionId }
    assert_redirected_to prorroga_path(assigns(:prorroga))
  end

  test "should destroy prorroga" do
    assert_difference('Prorroga.count', -1) do
      delete :destroy, id: @prorroga
    end

    assert_redirected_to prorrogas_path
  end
end
