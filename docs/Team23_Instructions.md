## Installation
To get started, clone this repository to your machine. Ensure that the correct version of Ruby on Rails is installed (3.0.2) with `ruby -v`.
Then navigate to the `\src` directory.
 - Install the dependencies by running
   - `bundle install`
   - `yarn install`
 - Setup the database by running
   - `rake db:create`
   - `rake db:migrate:reset`
   - `rake db:migrate`
   - `rake db:seed`
To run the application, first find your ip address with `ip addr show eth0`. Then run `rails s --binding xxx.xxx.xxx.xxx` where xxx.xxx.xxx.xxx is your ip address.
## Usage
The application provides functionality for both clients and admins.
### Client Usage
Sign in as a client, and then set up a household at the _Pre-Register_ section on the navigation bar.

#### Scheduling an Appointment
 - Navigate to the _Appointments_ section.
 - Selecting an open date on the calendar will allow you to see the available times that day. (Currently it only schedules at the Princeton pantry)
 - Below the calendar, you can select a location and date to book an appointment as well.
 - After creating an appointment, it will be moved to the existing appointments list, where you can cancel if needed.
#### Checking in to an Appointment
 - After making an appointment, navigate to the _Check-In_ section.
 - Your upcoming appointments are displayed in the Existing appointments list.
 - You can check into an appointment during the appointment time slot or up to 10 minutes before it starts.
 - After checking in for an appointment, it will be moved to the past appointments list.
### Admin Usage
Sign in as an admin.

#### Creating Events
- Select _Account_ and then _Admin Panel_ from the navigation bar.
- Here, you can see all the currently created events with their details.
- Select the Create New Event button to create a new event. You will be prompted to fill in the details (e.g. location and time)
- You can Edit and Delete previously created events as well.
#### Checking In Clients
- Navigate to the _Check-In_ section.
- Here you can see all the appointments and whether or not a client checked themselves in for their appointment.
- Additionally, you can check-in clients if they need assistance, by pressing the check-in button for their appointment.
- In case there is a mistake, you can also undo a check-in by selecting the Undo Check-In button in the list of checked in appointments.
