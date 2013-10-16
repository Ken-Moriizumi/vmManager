require 'test_helper'

class VminfosControllerTest < ActionController::TestCase
  setup do
    @vminfo = vminfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vminfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vminfo" do
    assert_difference('Vminfo.count') do
      post :create, vminfo: { ipaddress: @vminfo.ipaddress, name: @vminfo.name, path: @vminfo.path }
    end

    assert_redirected_to vminfo_path(assigns(:vminfo))
  end

  test "should show vminfo" do
    get :show, id: @vminfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vminfo
    assert_response :success
  end

  test "should update vminfo" do
    patch :update, id: @vminfo, vminfo: { ipaddress: @vminfo.ipaddress, name: @vminfo.name, path: @vminfo.path }
    assert_redirected_to vminfo_path(assigns(:vminfo))
  end

  test "should destroy vminfo" do
    assert_difference('Vminfo.count', -1) do
      delete :destroy, id: @vminfo
    end

    assert_redirected_to vminfos_path
  end
end
