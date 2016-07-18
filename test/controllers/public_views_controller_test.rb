require 'test_helper'

class PublicViewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_views_new_url
    assert_response :success
  end

end
