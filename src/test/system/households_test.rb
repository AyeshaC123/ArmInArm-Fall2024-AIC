require "application_system_test_case"

class HouseholdsTest < ApplicationSystemTestCase
  setup do
    @household = households(:one)
  end

  test "visiting the index" do
    visit households_url
    assert_selector "h1", text: "Households"
  end

  test "creating a Household" do
    visit households_url
    click_on "New Household"

    fill_in "City", with: @household.city
    fill_in "County", with: @household.county
    fill_in "Headdob", with: @household.headdob
    fill_in "Headethicity", with: @household.headethicity
    fill_in "Headgender", with: @household.headgender
    fill_in "Headname", with: @household.headname
    fill_in "Householdtype", with: @household.householdtype
    fill_in "Incomesource", with: @household.incomesource
    fill_in "Netincome", with: @household.netincome
    fill_in "Numadults", with: @household.numadults
    fill_in "Numchild", with: @household.numchild
    fill_in "Phonenum", with: @household.phonenum
    fill_in "Qualifiercode", with: @household.qualifiercode
    fill_in "State", with: @household.state
    fill_in "Streetaddr", with: @household.streetaddr
    fill_in "Zipcode", with: @household.zipcode
    click_on "Create Household"

    assert_text "Household was successfully created"
    click_on "Back"
  end

  test "updating a Household" do
    visit households_url
    click_on "Edit", match: :first

    fill_in "City", with: @household.city
    fill_in "County", with: @household.county
    fill_in "Headdob", with: @household.headdob
    fill_in "Headethicity", with: @household.headethicity
    fill_in "Headgender", with: @household.headgender
    fill_in "Headname", with: @household.headname
    fill_in "Householdtype", with: @household.householdtype
    fill_in "Incomesource", with: @household.incomesource
    fill_in "Netincome", with: @household.netincome
    fill_in "Numadults", with: @household.numadults
    fill_in "Numchild", with: @household.numchild
    fill_in "Phonenum", with: @household.phonenum
    fill_in "Qualifiercode", with: @household.qualifiercode
    fill_in "State", with: @household.state
    fill_in "Streetaddr", with: @household.streetaddr
    fill_in "Zipcode", with: @household.zipcode
    click_on "Update Household"

    assert_text "Household was successfully updated"
    click_on "Back"
  end

  test "destroying a Household" do
    visit households_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Household was successfully destroyed"
  end
end
