require 'test_helper'

class TwitterDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @twitter_datum = twitter_data(:one)
  end

  test "should get index" do
    get twitter_data_url
    assert_response :success
  end

  test "should get new" do
    get new_twitter_datum_url
    assert_response :success
  end

  test "should create twitter_datum" do
    assert_difference('TwitterDatum.count') do
      post twitter_data_url, params: { twitter_datum: {  } }
    end

    assert_redirected_to twitter_datum_url(TwitterDatum.last)
  end

  test "should show twitter_datum" do
    get twitter_datum_url(@twitter_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_twitter_datum_url(@twitter_datum)
    assert_response :success
  end

  test "should update twitter_datum" do
    patch twitter_datum_url(@twitter_datum), params: { twitter_datum: {  } }
    assert_redirected_to twitter_datum_url(@twitter_datum)
  end

  test "should destroy twitter_datum" do
    assert_difference('TwitterDatum.count', -1) do
      delete twitter_datum_url(@twitter_datum)
    end

    assert_redirected_to twitter_data_url
  end
end
