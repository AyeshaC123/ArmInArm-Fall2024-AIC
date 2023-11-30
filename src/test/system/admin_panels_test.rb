require "application_system_test_case"

class AdminPanelsTest < ApplicationSystemTestCase
  setup do
    @admin_panel = admin_panels(:one)
  end

  test "visiting the index" do
    visit admin_panels_url
    assert_selector "h1", text: "Admin Panels"
  end

  test "creating a Admin panel" do
    visit admin_panels_url
    click_on "New Admin Panel"

    fill_in "Appointment length", with: @admin_panel.appointment_length
    fill_in "Booking days", with: @admin_panel.booking_days
    fill_in "Max appointment count", with: @admin_panel.max_appointment_count
    fill_in "Service time", with: @admin_panel.service_time
    click_on "Create Admin panel"

    assert_text "Admin panel was successfully created"
    click_on "Back"
  end

  test "updating a Admin panel" do
    visit admin_panels_url
    click_on "Edit", match: :first

    fill_in "Appointment length", with: @admin_panel.appointment_length
    fill_in "Booking days", with: @admin_panel.booking_days
    fill_in "Max appointment count", with: @admin_panel.max_appointment_count
    fill_in "Service time", with: @admin_panel.service_time
    click_on "Update Admin panel"

    assert_text "Admin panel was successfully updated"
    click_on "Back"
  end

  test "destroying a Admin panel" do
    visit admin_panels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admin panel was successfully destroyed"
  end
end
