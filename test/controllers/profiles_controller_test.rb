require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get profiles_search_url
    assert_response :success
  end
end
