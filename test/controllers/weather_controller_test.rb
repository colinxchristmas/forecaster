require 'test_helper'

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weather_index_url
    assert_response :success
  end

  test "should get new" do
    get weather_new_url
    assert_response :success
  end

  test "should get show" do
    get weather_show_url
    assert_response :success
  end

end
