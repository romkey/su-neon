require 'test_helper'

class SignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sign = signs(:one)
  end

  test "should get index" do
    get signs_url
    assert_response :success
  end

  test "should get new" do
    get new_sign_url
    assert_response :success
  end

  test "should create sign" do
    assert_difference('Sign.count') do
      post signs_url, params: { sign: { name: @sign.name, particle_id: @sign.particle_id, relay: @sign.relay } }
    end

    assert_redirected_to sign_url(Sign.last)
  end

  test "should show sign" do
    get sign_url(@sign)
    assert_response :success
  end

  test "should get edit" do
    get edit_sign_url(@sign)
    assert_response :success
  end

  test "should update sign" do
    patch sign_url(@sign), params: { sign: { name: @sign.name, particle_id: @sign.particle_id, relay: @sign.relay } }
    assert_redirected_to sign_url(@sign)
  end

  test "should destroy sign" do
    assert_difference('Sign.count', -1) do
      delete sign_url(@sign)
    end

    assert_redirected_to signs_url
  end
end
