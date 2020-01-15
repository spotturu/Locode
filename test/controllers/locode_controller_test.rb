
require 'test_helper'

class LocodeControllerTest < ActionDispatch::IntegrationTest
  setup do
      @pagy, @data_array = LocodeService.new({code: "AD"}).search
  end

  test "should get index" do
     get locode_url
     assert_response :success
  end

  test "should get search" do
     pagy, data_array = LocodeService.new({code: "AD"}).search
     assert_not pagy.blank?
     assert_not data_array.blank?
  end

  test "should get not search" do
    pagy, data_array = LocodeService.new({code: "AD"}).search
    assert_not pagy.blank?
    assert_not data_array.blank?                                                                                                                                                                                  $  end

end
