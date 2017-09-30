require 'test_helper'

class NewsHitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news_hit = news_hits(:one)
  end

  test "should get index" do
    get news_hits_url
    assert_response :success
  end

  test "should get new" do
    get new_news_hit_url
    assert_response :success
  end

  test "should create news_hit" do
    assert_difference('NewsHit.count') do
      post news_hits_url, params: { news_hit: { keyword_id: @news_hit.keyword_id, news_source_id: @news_hit.news_source_id } }
    end

    assert_redirected_to news_hit_url(NewsHit.last)
  end

  test "should show news_hit" do
    get news_hit_url(@news_hit)
    assert_response :success
  end

  test "should get edit" do
    get edit_news_hit_url(@news_hit)
    assert_response :success
  end

  test "should update news_hit" do
    patch news_hit_url(@news_hit), params: { news_hit: { keyword_id: @news_hit.keyword_id, news_source_id: @news_hit.news_source_id } }
    assert_redirected_to news_hit_url(@news_hit)
  end

  test "should destroy news_hit" do
    assert_difference('NewsHit.count', -1) do
      delete news_hit_url(@news_hit)
    end

    assert_redirected_to news_hits_url
  end
end
