# **Arm in Arm Collab Group 21, Spring 2024**
## This project is designed to aid the staff, volunteers, and clients of the Arm in Arm program
## This project was created by students of The Collage of New Jersey, Software Engeering Class

## Installation
* Ensure that the correct version of Ruby on Rails is installed (3.0.2 as of 04/21/24) `ruby -v`
* Install the ArmInArm repository
* Clone the repository to your local machine
* Navigate to the '/src' directory
* Run the following commands:
    * `bundle install`
    * `yarn install`
* Create the database
    * `rake db:create`
    * `rake db:migrate:reset`
    * `rake db:migrate`
    * `rake db:seed`
 * Run the application
    * `ip addr show eth0`
    * `rails s --binding xxx.xxx.xxx.xxx`, where xxx.xxx.xxx.xxx is your ip address
    * In your browser, navigate to http://csc415-serverXX.hpc.tcnj.edu:3000/, where XX is your server number

## Use
* Sign into your administrator account
* Select the 'Statistics' link, located in the navigation bar at the top of the page
### Generate a Report
* View attendance data as a report within a certain time frame by entering valid dates in their corresponding fields and pressing 'Generate'
* Or view data within a generalized time frame (yesterday, last week, last month, etc.) by selecting the respective button and pressing 'Generate'
    * Select a location
    * Check the type of information to be included in the report (number of households, number of adults, number of children)
* Export the report as a CSV file or a PDF file by pressing 'Export Report' and selecting the desired file type
### Generate a Graph
* View attendance data as a graph or chart within a certain time frame by entering valid dates in their corresponding fields and pressing 'Generate'
* Or view data within a generalized time frame (yesterday, last week, last month, etc.) by selecting the respective button and pressing 'Generate'
    * Select bar graph or pie chart
    * Select a location
    * Check the type of information to be included in the report (number of households, number of adults, number of children)
 * Export the graph as a PNG by pressing the arrow in the top right corner of the generated image
