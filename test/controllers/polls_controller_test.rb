require 'test_helper'

class PollsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get polls_new_url
    assert_response :success
  end

end
