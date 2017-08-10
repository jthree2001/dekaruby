require 'test_helper'

class DenizensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @denizen = denizens(:one)
  end

  test "should get index" do
    get denizens_url
    assert_response :success
  end

  test "should get new" do
    get new_denizen_url
    assert_response :success
  end

  test "should create denizen" do
    assert_difference('Denizen.count') do
      post denizens_url, params: { denizen: { full_name: @denizen.full_name, nickname: @denizen.nickname } }
    end

    assert_redirected_to denizen_url(Denizen.last)
  end

  test "should show denizen" do
    get denizen_url(@denizen)
    assert_response :success
  end

  test "should get edit" do
    get edit_denizen_url(@denizen)
    assert_response :success
  end

  test "should update denizen" do
    patch denizen_url(@denizen), params: { denizen: { full_name: @denizen.full_name, nickname: @denizen.nickname } }
    assert_redirected_to denizen_url(@denizen)
  end

  test "should destroy denizen" do
    assert_difference('Denizen.count', -1) do
      delete denizen_url(@denizen)
    end

    assert_redirected_to denizens_url
  end
end
