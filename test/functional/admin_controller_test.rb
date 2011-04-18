require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get notes" do
    get :notes
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get flickr" do
    get :flickr
    assert_response :success
  end

  test "should get beautifulphotonet" do
    get :beautifulphotonet
    assert_response :success
  end

  test "should get sphotography" do
    get :sphotography
    assert_response :success
  end

  test "should get picasaweb" do
    get :picasaweb
    assert_response :success
  end

end
