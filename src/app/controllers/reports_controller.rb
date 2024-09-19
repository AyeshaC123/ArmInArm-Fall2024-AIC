# Project Name: Statistics: Reports and Graph Generation - Team 21
# Description: Enable clients to generate graphs to display Arm in Arm's data of people helped over time,
#   and enable admin users to generate downloadable reports of people helped over specific time frames.
# Filename: reports_controller.rb
# Description:  This controller is responsible for querying the database for data specified by users in the
#   form for report generation in the view file generate_reports.html.erb.
# Last Modified: 4/28/2024

class ReportsController < ApplicationController
  require 'csv'
  require 'fileutils'
  @@tempFileName = "a_report_pdf"
  @@tempFileExtension = ".html.erb"

  def getRouteForPDFTemplate
    route = nil
    if current_user.admin?
      userID = current_user.id.to_s
      route = "reports/#{@@tempFileName}#{userID}"
    else
      route = "reports/#{@@tempFileName}"
    end
    return route
  end

  def getPDFFileName
    filename = nil
    if current_user.admin?
      userID = current_user.id.to_s
      filename = @@tempFileName + userID + @@tempFileExtension
    else
      filename = @@tempFileName + @@tempFileExtension
    end
    return filename
  end

  # writes to html the current table information to be used as a template for pdf download
  def prepare_pdf
    content = params[:pdfContent]
    filename = getPDFFileName
    filepath = Rails.root.join("app", "views", "reports", filename)
    File.open(filepath, "w") do |file|
      file.write(content)
    end
    render json: { success: true }
  end

  # downloads report pdf onto clients device
  def download_pdf
    pdf = WickedPdf.new.pdf_from_string(render_to_string(getRouteForPDFTemplate, layout: false))
    send_data pdf, :filename => "ArmInArm_Report#{Date.today}.pdf", type: 'application/pdf', disposition: 'attachment'

    # delete the template html file after successful download
    filename = getPDFFileName
    filepath = Rails.root.join("app", "views", "reports", filename)
    FileUtils.rm(filepath, force: true)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "ArmInArm_Report", :template => 'report/generate_reports.html.erb', :disposition => 'attachment'
      end
    end
  end

  # def generate_reports
  #   @users_with_appointments = User.joins(client: :appointments)
  #   @total_clients = @users_with_appointments.distinct.count
  #   @average_appointments_per_client = (@users_with_appointments.group('users.id').count('appointments.id').values.sum.to_f / @total_clients).round(2)
  #   @average_appointments_per_client = (@users_with_appointments.group('users.id').count('appointments.id').values.sum.to_f / @total_clients).round(2)
  #   @total_children = 0
  #   @total_adults = 0

  #   @users_with_appointments.distinct.each do |user|
  #     household = user.household
  #     if household.present?
  #       # Add the number of children and adults in the household to the totals
  #       @total_children += household.numchild.presence || 0
  #       @total_adults += household.numadults.presence || 0
  #     end
  #   end


  #   @clients_with_appointments = Client.joins(:appointments)
  #                                   .group('clients.id')
  #                                   .select('clients.*, COUNT(appointments.id) AS appointment_count')

  #   @clients_with_appointments.each do |client|
  #     puts "#{client.first_name} #{client.last_name} has #{client.appointment_count} appointments."
  #   end

  #   # Other statistics calculations...

  #   # You can render a view to display the generated reports
  #   # render :generate_reports
  # end

  def index
    @reports = Report.all
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name"   # Excluding ".pdf" extension.
      end
    end
  end

  def new
    # @report = Report.new
    @report = Report.new
  end

  def edit
  end

  # POST /reports or /reports.json
  def create
    # @report = Report.new(report_params)
    @report = current_user.reports.build(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
    @report.destroy
  end

  # controller action that responds to post request for attended appointments report,
  #   returns specified data to be formatted in view as a report
  def getTableData_attendedAppointments
    # This method accepts a datetime object as argument and returns the date formatted as a string.
    def dateToStr(dateObj)
      return dateObj.strftime('%Y-%m-%d')
    end
    # This method accepts a datetime object as argument and returns the time formatted as a string.
    def timeToStr(dateObj)
      return dateObj.strftime("%l:%M %p")
    end

    # This method accepts a date formatted as a string and returns a date object.
    def strToDate(dateStr)
      dateFields = dateStr.split('-')
      date = DateTime.new(dateFields[0].to_i, dateFields[1].to_i, dateFields[2].to_i)
      return date
    end

    startDate = params[:initialDate]
    endDate = params[:finalDate]
    showTrenton = params[:showTrenton]
    showPrinceton = params[:showPrinceton]
    showMobilePantry = params[:showMobilePantry]
    orderByDate = params[:orderByDate]
    orderByLastName = params[:orderByLastName]

    startDateObj = strToDate(startDate)
    startDateObj = startDateObj.change(hour: 0, min: 0)
    endDateObj = strToDate(endDate)
    endDateObj = endDateObj.change(hour: 23, min: 59)

    newData = Array.new

    data = Appointment.joins(client: { users: :household })
                      .where(check_in_user: true)
                      .where(date_of_appt: startDateObj..endDateObj)

    data = data.where(location: "Trenton") if showTrenton
    data = data.where(location: "Princeton") if showPrinceton
    data = data.where(location: "Mobile Pantry") if showMobilePantry

    distinct_household_ids = data.distinct.pluck('households.id')
    distinct_clients = data.distinct.count('clients.id')
    totals = {
      'numAppointments' => data.count,
      'numAdult' => data.sum("households.numadults"),
      'uniqueAdult' => Household.where(id: distinct_household_ids).sum(:numadults),
      'numChild' => data.sum("households.numchild"),
      'uniqueChild' => Household.where(id: distinct_household_ids).sum(:numchild),
      'distinctClient' => data.distinct.count('clients.id'),
      'meanAppointmentsPerClient' => (data.count.to_f / distinct_clients).round(2)
    }
    newData.push(totals)

    data = data.select("date_of_appt,
                      time_of_appt,
                      clients.first_name,
                      clients.last_name,
                      households.numadults,
                      households.numchild,
                      households.county,
                      households.streetaddr,
                      households.zipcode")

    data = data.order("date_of_appt ASC, time_of_appt ASC") if orderByDate
    data = data.order("clients.last_name ASC") if orderByLastName

    counter = 1
    data.each do |appt|
      begin
        newEntry = {
        'index' => counter,
        'date' => appt.date_of_appt.strftime('%Y-%m-%d'),
        'time' => appt.time_of_appt.strftime("%l:%M %p"),
        'name' => "#{appt.first_name} #{appt.last_name}",
        'adults' => appt.numadults,
        'children' => appt.numchild,
        'county' => appt.county,
        'address' => appt.streetaddr,
        'zipCode' => appt.zipcode
      }
        newData.push(newEntry)
        counter += 1
      rescue => e
        next
      end
    end

    render json: {newData: newData}
  end

  # controller action that responds to post request for scheduled appointments report,
  #   returns specified data to be formatted in view as a report
  def getTableData_scheduledAppointments
    # This method accepts a datetime object as argument and returns the date formatted as a string.
    def dateToStr(dateObj)
      return dateObj.strftime('%Y-%m-%d')
    end
    # This method accepts a datetime object as argument and returns the time formatted as a string.
    def timeToStr(dateObj)
      return dateObj.strftime("%l:%M %p")
    end

    # This method accepts a date formatted as a string and returns a date object.
    def strToDate(dateStr)
      dateFields = dateStr.split('-')
      date = DateTime.new(dateFields[0].to_i, dateFields[1].to_i, dateFields[2].to_i)
      return date
    end

    startDate = params[:initialDate]
    endDate = params[:finalDate]
    showTrenton = params[:showTrenton]
    showPrinceton = params[:showPrinceton]
    showMobilePantry = params[:showMobilePantry]
    orderByDate = params[:orderByDate]
    orderByLastName = params[:orderByLastName]

    startDateObj = strToDate(startDate)
    startDateObj = startDateObj.change(hour: 0, min: 0)
    endDateObj = strToDate(endDate)
    endDateObj = endDateObj.change(hour: 23, min: 59)


    newData = Array.new

    data = Appointment.joins(client: { users: :household })
                      .where(check_in_user: false)
                      .where(date_of_appt: startDateObj..endDateObj)

    data = data.where(location: "Trenton") if showTrenton
    data = data.where(location: "Princeton") if showPrinceton
    data = data.where(location: "Mobile Pantry") if showMobilePantry

    distinct_household_ids = data.distinct.pluck('households.id')
    distinct_clients = data.distinct.count('clients.id')
    totals = {
      'numAppointments' => data.count,
      'numAdult' => data.sum("households.numadults"),
      'uniqueAdult' => Household.where(id: distinct_household_ids).sum(:numadults),
      'numChild' => data.sum("households.numchild"),
      'uniqueChild' => Household.where(id: distinct_household_ids).sum(:numchild),
      'distinctClient' => data.distinct.count('clients.id'),
      'meanAppointmentsPerClient' => (data.count.to_f / distinct_clients).round(2),
      'selfCheckedIn' => data.where(client_self_check_in: true).count
    }
    newData.push(totals)

    data = data.select("date_of_appt,
                      time_of_appt,
                      clients.first_name,
                      clients.last_name,
                      client_self_check_in,
                      households.numadults,
                      households.numchild,
                      households.county,
                      households.streetaddr,
                      households.zipcode")

    data = data.order("date_of_appt ASC, time_of_appt ASC") if orderByDate
    data = data.order("clients.last_name ASC") if orderByLastName

    counter = 1
    data.each do |appt|
      begin
        newEntry = {
        'index' => counter,
        'date' => appt.date_of_appt.strftime('%Y-%m-%d'),
        'time' => appt.time_of_appt.strftime("%l:%M %p"),
        'name' => "#{appt.first_name} #{appt.last_name}",
        'checkIn' => appt.client_self_check_in,
        'adults' => appt.numadults,
        'children' => appt.numchild,
        'county' => appt.county,
        'address' => appt.streetaddr,
        'zipCode' => appt.zipcode
      }
        newData.push(newEntry)
        counter += 1
      rescue => e
        next
      end
    end

    render json: {newData: newData}
  end

  # controller action that responds to post request for household appointments report,
  #   returns specified data to be formatted in view as a report
  def getTableData_householdAppointments
    # This method accepts a datetime object as argument and returns the date formatted as a string.
    def dateToStr(dateObj)
      return dateObj.strftime('%Y-%m-%d')
    end
    # This method accepts a datetime object as argument and returns the time formatted as a string.
    def timeToStr(dateObj)
      return dateObj.strftime("%l:%M %p")
    end
    # This method accepts a date formatted as a string and returns a date object.
    def strToDate(dateStr)
      dateFields = dateStr.split('-')
      date = Date.new(dateFields[0].to_i, dateFields[1].to_i, dateFields[2].to_i)
      return date
    end

    startDate = params[:initialDate]
    endDate = params[:finalDate]
    showTrenton = params[:showTrenton]
    showPrinceton = params[:showPrinceton]
    showMobilePantry = params[:showMobilePantry]

    # today = DateTime.now
    # yesterday = today-1

    startDateObj = strToDate(startDate)
    startDateObj = startDateObj.change(hour: 0, min: 0)
    endDateObj = strToDate(endDate)
    endDateObj = endDateObj.change(hour: 23, min: 59)

    newData = Array.new

    unconstrainedData = Appointment.joins(client: { users: :household })
    data = unconstrainedData.where(date_of_appt: startDateObj..endDateObj)
    data = data.where(location: "Trenton") if showTrenton
    data = data.where(location: "Princeton") if showPrinceton
    data = data.where(location: "Mobile Pantry") if showMobilePantry
    data = data.select("households.id")

    # upcomingAppointments = data.where(date_of_appt: today..endDateObj)
    # pastAppointments = data.where(date_of_appt: startDateObj..yesterday)
    # attendedAppointments = pastAppointments.where(check_in_user: true)
    # missedAppointments = pastAppointments.where(check_in_user: false)

    totals = {
      'households' => Household.count,
      'adults' => Household.sum(:numadults),
      'children' => Household.sum(:numchild)
    }
    newData.push(totals)

    distinct_household_ids = data.select("households.id").distinct
                                .pluck('households.id')

    counter = 1
    distinct_household_ids.each do |householdID|
      household = Household.find_by(id: householdID)
      begin
        # Rails.logger.info counter
        # Rails.logger.info household.headname
        # Rails.logger.info household.numadults
        # Rails.logger.info household.numchild
        # Rails.logger.info household.county
        # Rails.logger.info household.streetaddr
        # Rails.logger.info household.zipcode

        # Rails.logger.info data.where('clients.households.id' => householdID).count
        # Rails.logger.info attendedAppointments.where('clients.households.id' => householdID).count
        # Rails.logger.info missedAppointments.where('clients.households.id' => householdID).count
        # Rails.logger.info upcomingAppointments.where('clients.households.id' => householdID).count
        # Rails.logger.info unconstrainedData.where('clients.households.id' => householdID).count
        newEntry = {
        'index' => counter,
        'name' => household.headname,
        'adults' => household.numadults,
        'children' => household.numchild,
        'county' => household.county,
        'address' => household.streetaddr,
        'zipCode' => household.zipcode,
        # 'apptsInTimeWindow' => data.where('households.id' => householdID).count,
        # 'attendedAppt' => attendedAppointments.where('households.id' => householdID).count,
        # 'missedAppt' => missedAppointments.where('households.id' => householdID).count,
        # 'scheduledAppt' => upcomingAppointments.where('households.id' => householdID).count,
        # 'totalAppt' => unconstrainedData.where('households.id' => householdID).count
      }
        newData.push(newEntry)
        counter += 1
      rescue => e
        next
      end
    end

    render json: {newData: newData}
  end

  private
    def set_member
      @report = Report.find(params[:id])
    end

    def member_params
      params.require(:member).permit()
    end
end
