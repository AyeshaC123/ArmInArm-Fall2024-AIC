# Project Name: Statistics: Reports and Graph Generation - Team 21
# Description: Enable clients to generate graphs to display Arm in Arm's data of people helped over time,
#   and enable admin users to generate downloadable reports of people helped over specific time frames.
# Filename: graphics_controller.rb
# Description:  This controller is responsible for querying the database for data specified by users in the
#   form for chart generation in the view file graph_generator.html.erb.
# Last Modified: 4/21/2024
#
class GraphicsController < ApplicationController
  require 'date'
  require 'groupdate'

  # When the user clicks generate while the bar chart radio button is checked and location comparison
  #   mode checkbox is unchecked, a post request is generated which is handled by this controller action.
  # This returns the data for a column chart with 1-3 columns per date grouping (either day, week, or month).
  def getBarChartData
    # variables used as constants that correspond to the grouping types
    @GROUP_BY_DAY = 0
    @GROUP_BY_WEEK = 1
    @GROUP_BY_MONTH = 2

    # This method accepts a date object as argument and returns it formatted as a string.
    def dateToStr(dateObj)
      return dateObj.strftime('%Y-%m-%d')
    end

    # This method accepts a date formatted as a string and returns a date object.
    def strToDate(dateStr)
      dateFields = dateStr.split('-')
      date = Date.new(dateFields[0].to_i, dateFields[1].to_i, dateFields[2].to_i)
      return date
    end

    # This controller action either graphs data from all locations or a specific location.
    # Therefore, if one location's information is being graphed, then this method accepts the
    #   three boolean variables as argument, assuming one will be true, and returns the string
    #   string for filtering the data by location.
    def getLocationString(trenton, princeton, mobilePantry)
      if trenton
        return "Trenton"
      elsif princeton
        return "Princeton"
      else
        return "Mobile Pantry"
      end
    end

    # the parameters sent by the post request are stored in local variables
    startDate = params[:initialDate]
    endDate = params[:finalDate]
    includeAppointments = params[:includeAppointments]
    includeAdults = params[:includeAdults]
    includeChildren = params[:includeChildren]
    filterByLocation = params[:filterByLocation]
    includeTrenton = params[:includeTrenton]
		includePrinceton = params[:includePrinceton]
		includeMobilePantry = params[:includeMobilePantry]
    groupBy = params[:groupingOption]

    # Rails.logger.info startDate.class
    # Rails.logger.info endDate.class
    # Rails.logger.info includeAppointments
    # Rails.logger.info includeAdults
    # Rails.logger.info includeChildren
    # Rails.logger.info groupBy

    # we convert the date strings to date objects such that we can query for Appointment entries
    #   in the range between them.
    startDateObj = strToDate(startDate)
    startDateObj = startDateObj.change(hour: 0, min: 0)
    endDateObj = strToDate(endDate)
    endDateObj = endDateObj.change(hour: 23, min: 59)

    # if we are filtering by location, then we assign the location filter to be a string we use to
    #   to query for appointments exclusively from a given location.
    locationFilter = nil
    if filterByLocation
      locationFilter = getLocationString(includeTrenton, includePrinceton, includeMobilePantry)
    end

    newData = Array.new # array that will be populated with data entries
    if includeAppointments
      appointmentData = Appointment.where(check_in_user: true)
      appointmentData = appointmentData.where(location: locationFilter) if filterByLocation
      appointmentEntry = nil
      if groupBy == @GROUP_BY_DAY
        appointmentEntry = {
          name: "Appointments",
          data: appointmentData.where(date_of_appt: startDateObj..endDateObj)
                            .group("DATE(date_of_appt)")
                            .order("DATE(date_of_appt)")
                            .count,
        }
      elsif groupBy == @GROUP_BY_WEEK
        appointmentEntry = {
          name: "Appointments",
          data: appointmentData.where(date_of_appt: startDateObj.beginning_of_week..endDateObj.end_of_week)
                            .group_by_week(:date_of_appt)
                            .count.transform_keys { |date| date.strftime("%Y-%m-%d") }
                            .sort_by { |date, _| Date.parse(date) }
                            .to_h,
        }
      else # group by month
        appointmentEntry = {
          name: "Appointments",
          data: appointmentData.where(date_of_appt: startDateObj.beginning_of_month..endDateObj.end_of_month)
                            .group_by_month(:date_of_appt)
                            .count.transform_keys { |date| date.strftime("%Y-%m") }
                            .sort_by { |date, _| Date.parse("#{date}-01") }
                            .to_h,
        }
      end
      newData.push(appointmentEntry)
    end
    if includeAdults
      adultData = Appointment.joins(client: { users: :household }).where(check_in_user: true)
      adultData = adultData.where(location: locationFilter) if filterByLocation
      adultEntry = nil
      if groupBy == @GROUP_BY_DAY
        adultEntry = {
          name: "Adults",
          data: adultData.where(date_of_appt: startDateObj..endDateObj)
                          .group("DATE(date_of_appt)")
                          .order("DATE(date_of_appt)")
                          .sum("households.numadults"),
        }
      elsif groupBy == @GROUP_BY_WEEK
        adultEntry = {
          name: "Adults",
          data: adultData.where(date_of_appt: startDateObj.beginning_of_week..endDateObj.end_of_week)
                          .group_by_week(:date_of_appt)
                          .sum("households.numadults").transform_keys { |date| date.strftime("%Y-%m-%d") }
                          .sort_by { |date, _| Date.parse(date) }
                          .to_h,
        }
      else # group by month
        adultEntry = {
          name: "Adults",
          data: adultData.where(date_of_appt: startDateObj.beginning_of_month..endDateObj.end_of_month)
                          .group_by_month(:date_of_appt)
                          .sum("households.numadults").transform_keys { |date| date.strftime("%Y-%m") }
                          .sort_by { |date, _| Date.parse("#{date}-01") }
                          .to_h,
        }
      end
      newData.push(adultEntry)
    end
    if includeChildren
      childData = Appointment.joins(client: { users: :household }).where(check_in_user: true)
      childData = childData.where(location: locationFilter) if filterByLocation
      childEntry = nil
      if groupBy == @GROUP_BY_DAY
        childEntry = {
          name: "Children",
          data: childData.where(date_of_appt: startDateObj..endDateObj)
                          .group("DATE(date_of_appt)")
                          .order("DATE(date_of_appt)")
                          .sum("households.numchild"),
        }
      elsif groupBy == @GROUP_BY_WEEK
        childEntry = {
          name: "Children",
          data: childData.where(date_of_appt: startDateObj.beginning_of_week..endDateObj.end_of_week)
                          .group_by_week(:date_of_appt)
                          .sum("households.numchild").transform_keys { |date| date.strftime("%Y-%m-%d") }
                          .sort_by { |date, _| Date.parse(date) }
                          .to_h,
        }
      else # group by month
        childEntry = {
          name: "Children",
          data: childData.where(date_of_appt: startDateObj.beginning_of_month..endDateObj.end_of_month)
                          .group_by_month(:date_of_appt)
                          .sum("households.numchild").transform_keys { |date| date.strftime("%Y-%m") }
                          .sort_by { |date, _| Date.parse("#{date}-01") }
                          .to_h,
        }
      end
      newData.push(childEntry)
    end
    # respond to post request with the requested data
    render json: {newData: newData}
  end

  # When the user clicks generate while the pie chart radio button is checked, a post request is generated
  #   which is handled by this controller action.
  # This returns the data for a pie chart with the number of appointments where people were served by
  #   Arm in Arm at some combination of Arm in Arm's locations
  def getPieChartData
    # the parameters sent by the post request are stored in local variables
    startDate = params[:initialDate]
    endDate = params[:finalDate]
    includeTrenton = params[:includeTrenton]
		includePrinceton = params[:includePrinceton]
		includeMobilePantry = params[:includeMobilePantry]

    # Rails.logger.info startDate.class
    # Rails.logger.info endDate.class

    # we convert the date strings to date objects such that we can query for Appointment entries
    #   in the range between them.
    startDateObj = strToDate(startDate)
    startDateObj = startDateObj.change(hour: 0, min: 0)
    endDateObj = strToDate(endDate)
    endDateObj = endDateObj.change(hour: 23, min: 59)

    # the locations tha will be included in the pie chart are pushed to an array as strings such that we
    #   can loop through them in retrieving the data
    locationsToConsider = Array.new
    locationsToConsider.push("Trenton") if includeTrenton
    locationsToConsider.push("Princeton") if includePrinceton
    locationsToConsider.push("Mobile Pantry") if includeMobilePantry

    # initialize this variable with the appointments within the desired time window, and where the client
    #   checked in on-site
    appointments = Appointment.where(check_in_user: true)
                              .where(date_of_appt: startDateObj..endDateObj)

    newData = Hash.new # hash that will be populated with data entries
    locationsToConsider.each do |locationStr|
      newData[locationStr] = appointments.where(location: locationStr).count
    end
    # respond to post request with the requested data
    render json: {newData: newData}
  end

  # When the user clicks generate while the bar chart radio button and location comparison mode checkbox is
  #   unchecked, a post request is generated which is handled by this controller action.
  # This returns the data for a stacked column chart with 1 columns per date grouping (either day, week, or month).
  def getStackedBarChartData
    # variables used as constants that correspond to the grouping types
    @GROUP_BY_DAY = 0
    @GROUP_BY_WEEK = 1
    @GROUP_BY_MONTH = 2

    # This method accepts a date object as argument and returns it formatted as a string.
    def dateToStr(dateObj)
      return dateObj.strftime('%Y-%m-%d')
    end

    # This method accepts a date formatted as a string and returns a date object.
    def strToDate(dateStr)
      dateFields = dateStr.split('-')
      date = Date.new(dateFields[0].to_i, dateFields[1].to_i, dateFields[2].to_i)
      return date
    end

    # the parameters sent by the post request are stored in local variables
    startDate = params[:initialDate]
    endDate = params[:finalDate]
    # includeAppointments = params[:includeAppointments]
    includeTrenton = params[:includeTrenton]
		includePrinceton = params[:includePrinceton]
		includeMobilePantry = params[:includeMobilePantry]
    groupBy = params[:groupingOption]


    # Rails.logger.info startDate.class
    # Rails.logger.info endDate.class
    # Rails.logger.info includeTrenton
    # Rails.logger.info includePrinceton
    # Rails.logger.info includeMobilePantry
    # Rails.logger.info groupBy

    # we convert the date strings to date objects such that we can query for Appointment entries
    #   in the range between them.
    startDateObj = strToDate(startDate)
    startDateObj = startDateObj.change(hour: 0, min: 0)
    endDateObj = strToDate(endDate)
    endDateObj = endDateObj.change(hour: 23, min: 59)

    # strings for querying appointments based on location
    trentonStr = "Trenton"
    princetonStr = "Princeton"
    mobilePantryStr = "Mobile Pantry"

    newData = Array.new # array that will be populated with data entries

    appointmentData = Appointment.where(check_in_user: true)
    appointmentEntry = nil
    if groupBy == @GROUP_BY_DAY
      if includeTrenton
        appointmentEntry = {
        name: "Trenton Appointments",
        data: appointmentData.where(date_of_appt: startDateObj..endDateObj)
                          .where(location: trentonStr)
                          .group("DATE(date_of_appt)")
                          .order("DATE(date_of_appt)")
                          .count,
        stack: "stack 1",
        }
        Rails.logger.info appointmentEntry
        newData.push(appointmentEntry)
      end
      if includePrinceton
        appointmentEntry = {
        name: "Princeton Appointments",
        data: appointmentData.where(date_of_appt: startDateObj..endDateObj)
                          .where(location: princetonStr)
                          .group("DATE(date_of_appt)")
                          .order("DATE(date_of_appt)")
                          .count,
        stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
      if includeMobilePantry
        appointmentEntry = {
        name: "Mobile Pantry Appointments",
        data: appointmentData.where(date_of_appt: startDateObj..endDateObj)
                          .where(location: mobilePantryStr)
                          .group("DATE(date_of_appt)")
                          .order("DATE(date_of_appt)")
                          .count,
        stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
    elsif groupBy == @GROUP_BY_WEEK
      if includeTrenton
        appointmentEntry = {
        name: "Trenton Appointments",
        data: appointmentData.where(date_of_appt: startDateObj.beginning_of_week..endDateObj.end_of_week)
                          .where(location: trentonStr)
                          .group_by_week(:date_of_appt)
                          .count.transform_keys { |date| date.strftime("%Y-%m-%d") }
                          .sort_by { |date, _| Date.parse(date) }
                          .to_h,
        stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
      if includePrinceton
        appointmentEntry = {
        name: "Princeton Appointments",
        data: appointmentData.where(date_of_appt: startDateObj.beginning_of_week..endDateObj.end_of_week)
                          .where(location: princetonStr)
                          .group_by_week(:date_of_appt)
                          .count.transform_keys { |date| date.strftime("%Y-%m-%d") }
                          .sort_by { |date, _| Date.parse(date) }
                          .to_h,
        stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
      if includeMobilePantry
        appointmentEntry = {
          name: "Mobile Pantry Appointments",
          data: appointmentData.where(date_of_appt: startDateObj.beginning_of_week..endDateObj.end_of_week)
                            .where(location: mobilePantryStr)
                            .group_by_week(:date_of_appt)
                            .count.transform_keys { |date| date.strftime("%Y-%m-%d") }
                            .sort_by { |date, _| Date.parse(date) }
                            .to_h,
          stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
    else # group by month
      if includeTrenton
        appointmentEntry = {
          name: "Trenton Appointments",
          data: appointmentData.where(date_of_appt: startDateObj.beginning_of_month..endDateObj.end_of_month)
                            .where(location: trentonStr)
                            .group_by_month(:date_of_appt)
                            .count.transform_keys { |date| date.strftime("%Y-%m") }
                            .sort_by { |date, _| Date.parse("#{date}-01") }
                            .to_h,
          stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
      if includePrinceton
        appointmentEntry = {
          name: "Princeton Appointments",
          data: appointmentData.where(date_of_appt: startDateObj.beginning_of_month..endDateObj.end_of_month)
                            .where(location: princetonStr)
                            .group_by_month(:date_of_appt)
                            .count.transform_keys { |date| date.strftime("%Y-%m") }
                            .sort_by { |date, _| Date.parse("#{date}-01") }
                            .to_h,
          stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
      if includeMobilePantry
        appointmentEntry = {
          name: "Mobile Pantry Appointments",
          data: appointmentData.where(date_of_appt: startDateObj.beginning_of_month..endDateObj.end_of_month)
                            .where(location: mobilePantryStr)
                            .group_by_month(:date_of_appt)
                            .count.transform_keys { |date| date.strftime("%Y-%m") }
                            .sort_by { |date, _| Date.parse("#{date}-01") }
                            .to_h,
          stack: "stack 1"
        }
        newData.push(appointmentEntry)
      end
    end
    # respond to post request with the requested data
    render json: {newData: newData}
  end
end
