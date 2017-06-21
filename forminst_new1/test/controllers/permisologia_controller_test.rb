require 'test_helper'

class PermisologiaControllerTest < ActionController::TestCase
  setup do
    @permisologium = permisologia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:permisologia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create permisologium" do
    assert_difference('Permisologium.count') do
      post :create, permisologium: { attribute: @permisologium.attribute, id: @permisologium.id, permisosId: @permisologium.permisosId, read: @permisologium.read, usuarioId: @permisologium.usuarioId, write: @permisologium.write }
    end

    assert_redirected_to permisologium_path(assigns(:permisologium))
  end

  test "should show permisologium" do
    get :show, id: @permisologium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @permisologium
    assert_response :success
  end

  test "should update permisologium" do
    patch :update, id: @permisologium, permisologium: { attribute: @permisologium.attribute, id: @permisologium.id, permisosId: @permisologium.permisosId, read: @permisologium.read, usuarioId: @permisologium.usuarioId, write: @permisologium.write }
    assert_redirected_to permisologium_path(assigns(:permisologium))
  end

  test "should destroy permisologium" do
    assert_difference('Permisologium.count', -1) do
      delete :destroy, id: @permisologium
    end

    assert_redirected_to permisologia_path
  end
end
