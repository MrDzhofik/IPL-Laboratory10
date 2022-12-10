require "test_helper"

class ProxyControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get proxy_input_url
    assert_response :success
  end

  test "should get view" do
    get proxy_view_url
    assert_response :success
  end
end
