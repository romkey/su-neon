require 'test_helper'

class RecentHeadlinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recent_headline = recent_headlines(:one)
  end

  test "should get index" do
    get recent_headlines_url
    assert_response :success
  end

  test "should get new" do
    get new_recent_headline_url
    assert_response :success
  end

  test "should create recent_headline" do
    assert_difference('RecentHeadline.count') do
      post recent_headlines_url, params: { recent_headline: {  } }
    end

    assert_redirected_to recent_headline_url(RecentHeadline.last)
  end

  test "should show recent_headline" do
    get recent_headline_url(@recent_headline)
    assert_response :success
  end

  test "should get edit" do
    get edit_recent_headline_url(@recent_headline)
    assert_response :success
  end

  test "should update recent_headline" do
    patch recent_headline_url(@recent_headline), params: { recent_headline: {  } }
    assert_redirected_to recent_headline_url(@recent_headline)
  end

  test "should destroy recent_headline" do
    assert_difference('RecentHeadline.count', -1) do
      delete recent_headline_url(@recent_headline)
    end

    assert_redirected_to recent_headlines_url
  end
end
