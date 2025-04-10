require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @member = members(:one)
  end

  test "visiting the index" do
    visit members_url
    assert_selector "h1", text: "Members"
  end

  test "creating a Member" do
    visit members_url
    click_on "New Member"

    fill_in "Dob", with: @member.dob
    fill_in "Firstname", with: @member.firstname
    fill_in "Household", with: @member.household_id
    fill_in "Lastname", with: @member.lastname
    fill_in "Relationship", with: @member.relationship
    click_on "Create Member"

    assert_text "Member was successfully created"
    click_on "Back"
  end

  test "updating a Member" do
    visit members_url
    click_on "Edit", match: :first

    fill_in "Dob", with: @member.dob
    fill_in "Firstname", with: @member.firstname
    fill_in "Household", with: @member.household_id
    fill_in "Lastname", with: @member.lastname
    fill_in "Relationship", with: @member.relationship
    click_on "Update Member"

    assert_text "Member was successfully updated"
    click_on "Back"
  end

  test "destroying a Member" do
    visit members_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Member was successfully destroyed"
  end
end
