require "test_helper"

class RoundControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get round_update_url
    assert_response :success
  end
end
