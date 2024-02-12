require 'test_helper'

class AdminPanelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_panel = admin_panels(:one)
  end

  test "should get index" do
    get admin_panels_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_panel_url
    assert_response :success
  end

  test "should create admin_panel" do
    assert_difference('AdminPanel.count') do
      post admin_panels_url, params: { admin_panel: { appointment_length: @admin_panel.appointment_length, booking_days: @admin_panel.booking_days, max_appointment_count: @admin_panel.max_appointment_count, service_time: @admin_panel.service_time } }
    end

    assert_redirected_to admin_panel_url(AdminPanel.last)
  end

  test "should show admin_panel" do
    get admin_panel_url(@admin_panel)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_panel_url(@admin_panel)
    assert_response :success
  end

  test "should update admin_panel" do
    patch admin_panel_url(@admin_panel), params: { admin_panel: { appointment_length: @admin_panel.appointment_length, booking_days: @admin_panel.booking_days, max_appointment_count: @admin_panel.max_appointment_count, service_time: @admin_panel.service_time } }
    assert_redirected_to admin_panel_url(@admin_panel)
  end

  test "should destroy admin_panel" do
    assert_difference('AdminPanel.count', -1) do
      delete admin_panel_url(@admin_panel)
    end

    assert_redirected_to admin_panels_url
  end
end
