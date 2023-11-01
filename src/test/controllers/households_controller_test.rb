require 'test_helper'

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @household = households(:one)
  end

  test "should get index" do
    get households_url
    assert_response :success
  end

  test "should get new" do
    get new_household_url
    assert_response :success
  end

  test "should create household" do
    assert_difference('Household.count') do
      post households_url, params: { household: { city: @household.city, county: @household.county, headdob: @household.headdob, headethicity: @household.headethicity, headgender: @household.headgender, headname: @household.headname, householdtype: @household.householdtype, incomesource: @household.incomesource, netincome: @household.netincome, numadults: @household.numadults, numchild: @household.numchild, phonenum: @household.phonenum, qualifiercode: @household.qualifiercode, state: @household.state, streetaddr: @household.streetaddr, zipcode: @household.zipcode } }
    end

    assert_redirected_to household_url(Household.last)
  end

  test "should show household" do
    get household_url(@household)
    assert_response :success
  end

  test "should get edit" do
    get edit_household_url(@household)
    assert_response :success
  end

  test "should update household" do
    patch household_url(@household), params: { household: { city: @household.city, county: @household.county, headdob: @household.headdob, headethicity: @household.headethicity, headgender: @household.headgender, headname: @household.headname, householdtype: @household.householdtype, incomesource: @household.incomesource, netincome: @household.netincome, numadults: @household.numadults, numchild: @household.numchild, phonenum: @household.phonenum, qualifiercode: @household.qualifiercode, state: @household.state, streetaddr: @household.streetaddr, zipcode: @household.zipcode } }
    assert_redirected_to household_url(@household)
  end

  test "should destroy household" do
    assert_difference('Household.count', -1) do
      delete household_url(@household)
    end

    assert_redirected_to households_url
  end
end
