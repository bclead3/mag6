require 'test_helper'

class EarthquakesControllerTest < ActionController::TestCase
  setup do
    @earthquake = earthquakes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:earthquakes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create earthquake" do
    assert_difference('Earthquake.count') do
      post :create, earthquake: { depth: @earthquake.depth, dmin: @earthquake.dmin, gap: @earthquake.gap, latitude: @earthquake.latitude, longitude: @earthquake.longitude, mag: @earthquake.mag, mag_type: @earthquake.mag_type, net: @earthquake.net, nst: @earthquake.nst, place: @earthquake.place, quake_identifier: @earthquake.quake_identifier, quake_type: @earthquake.quake_type, rms: @earthquake.rms, time_of_day: @earthquake.time_of_day, time_stamp: @earthquake.time_stamp, updated: @earthquake.updated }
    end

    assert_redirected_to earthquake_path(assigns(:earthquake))
  end

  test "should show earthquake" do
    get :show, id: @earthquake
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @earthquake
    assert_response :success
  end

  test "should update earthquake" do
    patch :update, id: @earthquake, earthquake: { depth: @earthquake.depth, dmin: @earthquake.dmin, gap: @earthquake.gap, latitude: @earthquake.latitude, longitude: @earthquake.longitude, mag: @earthquake.mag, mag_type: @earthquake.mag_type, net: @earthquake.net, nst: @earthquake.nst, place: @earthquake.place, quake_identifier: @earthquake.quake_identifier, quake_type: @earthquake.quake_type, rms: @earthquake.rms, time_of_day: @earthquake.time_of_day, time_stamp: @earthquake.time_stamp, updated: @earthquake.updated }
    assert_redirected_to earthquake_path(assigns(:earthquake))
  end

  test "should destroy earthquake" do
    assert_difference('Earthquake.count', -1) do
      delete :destroy, id: @earthquake
    end

    assert_redirected_to earthquakes_path
  end
end
