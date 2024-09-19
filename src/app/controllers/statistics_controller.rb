=begin
Project Name: Statistics: Reports and Graph Generation - Team 21
Description: Enable clients to generate graphs to display Arm in Arm's data of people helped over time,
	and enable admin users to generate downloadable reports of people helped over specific time frames.
Filename: statistics_controller.rb
Description: This file contains the logic for handling various tasks related to the statistics page of the admin dashboard, such as exporting reports and graphs
Last Modified: 4/21/2024
=end

class StatisticsController < ApplicationController
  def index
  end

  def show
  end
  
  def export_report_as_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "report.pdf", :template => 'reports/generate_reports.html.erb', :layout => "pdf.html", :javascript_delay => 3000
      end
    end
  end

  def export_report_as_csv
    require 'csv'
    filename = "Report.csv"
    headers = ["Date", "Location", "Total attendees", "Adults", "Children"];
    CSV.open(filename, "w") do |csv|
      csv.puts headers
    end
  end

  def export_graph_as_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "ArmInArm_Graph", :template => 'statistics/graph_generator.html.erb', :disposition => 'attachment', :javascript_delay => 3000
      end
    end
  end

end
