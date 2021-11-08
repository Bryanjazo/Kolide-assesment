require "test_helper"

class Api::PingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_ping = api_pings(:one)
  end

  test "should get index" do
    get api_pings_url, as: :json
    assert_response :success
  end

  test "should create api_ping" do
    assert_difference('Api::Ping.count') do
      post api_pings_url, params: { api_ping: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_ping" do
    get api_ping_url(@api_ping), as: :json
    assert_response :success
  end

  test "should update api_ping" do
    patch api_ping_url(@api_ping), params: { api_ping: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_ping" do
    assert_difference('Api::Ping.count', -1) do
      delete api_ping_url(@api_ping), as: :json
    end

    assert_response 204
  end
end
