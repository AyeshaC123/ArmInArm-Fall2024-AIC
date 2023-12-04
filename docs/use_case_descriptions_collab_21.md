### Use Case: Provide Feedback
Primary Actor: Registering User

Goal in Context: Allow users to provide helpful feedback to improve the system. 
Preconditions: Users must be registered.

Trigger: Will prompt users after a set amount of usage, or available to users at any time.
Scenario: 
1) User observes prompt to provide feedback.
2) User enters and submits feedback.
3) Feedback is sent back to the server and stored anonymously.

Exceptions: 1) User feedback is not coherent/helpful or is not applicable to the scope of the project. Admins choose to filter out unhelpful suggestions. 2) 
Priority: Medium. Will be implemented after main functionality. 
When Available: Last increment
Frequency of Use: Few times per day. 
Channel to Actor: Via main project interface
Secondary Actors: Admin
Channel to Secondary Actors: Via Admin interface
Open Issues: 1) Do we filter the feedback automatically? 2) Do we require users to use certain functionality first?

### Use Case: Create Appointment
Primary Actor: Registering User

Goal in Context: Create an appointment for the user to go receive services at the ArmInArm site at the selected time. 
Preconditions: User is registered. 

Trigger: User selects the create appointment option. 
Scenario: 
1) User logs in.
2) User selects the create appointment option from the main interface.
3) User selects a time slot and confirms the appointment.

Exceptions: 1)  User has made a previous appointment in the same time slot. Users are prompted to reselect a new time slot. 2) Selected time slot already has too many appointments. Users are prompted to reselect a new time slot.3) Time slots are not enforced so the user shows up outside of the time slot. The appointment is still fulfilled, the user’s wait time is just different. 
Priority: Essential
When Available: First Increment
Frequency of Use: Many times per day
Channel to Actor: Main interface
Secondary Actors: Admins
Channel to Secondary Actors: Admin Interface
Open Issues: 1) Currently have no applicable database so appointments are fake. 2) WIll need some way to verify users are registered. 

### Use Case: Cancel Appointment
Primary Actor: Registering User 
Goal in Context: The goal is to allow registered users to cancel their scheduled appointments within the appointment-based system. Users can cancel appointments they no longer plan to attend.
Preconditions: User is registered. The user has an appointment they are trying to cancel
Trigger: User selects cancel appointment
Scenario:1) User logs in. 2) User selects the view appointment option from the main interface. 3) User navigates to the appointment location and clicks cancel the appointment. 
Exceptions: Users do no have an appointment 
Priority: High
When Available: When users have an appointment made and navigate to view appointments
Frequency of Use: As frequently as needed by user, might be because of time conflict that rises or mistake in chosen time
Channel to Actor: Main interface
Secondary Actors: Admins
Channel to Secondary Actors: Admin interface
Open Issues: 1) Currently have no database where said appointments will be stored yet

### Use Case: View Appointment
Primary Actor: Registering User
Goal in Context: to enable users to view their scheduled appointments, gaining essential information about the appointment, such as date, time, location, description, and any other relevant details. 
Preconditions: User is registered
Trigger: logged in user selects View appointment option on the Nav Bar
Scenario: 1) User logs in. 2) User selects the view appointment option from the main interface. 3) Details of appointment are displayed
Exceptions: If the user does not have any appointments associated with their account, the system displays a message indicating that there are no appointments to view.
Priority: Essential
When Available: First Increment
Frequency of Use: Potentially many times a day
Channel to Actor: Main interface
Secondary Actors: Admins
Channel to Secondary Actors: Via admin interface
Open Issues: 1) no database yet where appointments will be stored 2) will need a way to link appointments info to registered accounts

### Use Case: View Past Appointments
Primary Actor: Registering User
Goal in Context: The goal is to allow registered users to view their past appointments, providing them with access to historical appointment data 
Preconditions: User is registered.
Trigger: The user initiates the action to view their past appointments, typically by navigating to the "View Past Appointments" section
Scenario: 1) User logs in 2) User navigates to view past appointments section 3) Past appointment history is displayed
Exceptions: No past appointments history is available. 
Priority: High
When Available: Throughout the user's interaction with the system, particularly when they need to review past appointments.
Frequency of Use: Users may view past appointments frequently, depending on their appointment history and the nature of the application.
Channel to Actor: Main interface
Secondary Actors: Admins
Channel to Secondary Actors: Admin interface
Open Issues: 1) Currently have no applicable database 2) in the future it might be necessary to add a way to sort/filter appointments

### Use Case: View Wait Time
Primary Actor: Registering User
Goal in Context: the goal is to provide registered users with real-time information about the estimated wait time for their scheduled appointments, enabling them to better plan their arrival and minimize wait times.
Preconditions: User is registered 
Trigger: The user initiates the action to check the estimated wait time for their scheduled appointments
Scenario: 1) User logs in 2) User clicks view appointment on main interface 3) user then selects view estimated wait time 4) wait time is displayed
Exceptions: there are no scheduled appointments
Priority: High
When Available: First increment
Frequency of Use: Users may check wait times frequently, depending on the nature of the appointments.
Channel to Actor: Main interface
Secondary Actors: admins
Channel to Secondary Actors: admin interface
Open Issues: 1) Currently need to find a way to effectively source and generate estimated wait times

### Use Case: Create Appointment Blocks
Primary Actor: Admin User
Goal in Context: The goal is to allow admin users to create appointment blocks, which represent available time slots for appointments. Admin users can customize these blocks to set specific time intervals for appointments, enabling efficient scheduling and optimization of client interactions.
Preconditions: The admin is registered and authenticated in the system
Trigger: The admin user initiates the action to create new appointment blocks, from the admin interface.
Scenario: 1) Admin logs on 2) admin interface is displayed 3) Admin navigates to create appointment blocks section 4) system provides the admin user with options to define appointment block details, such as start time, end time, available dates 5) admin sets parameters 6) admin saves schedule 
Exceptions: No admin privilege
Priority: High
When Available: throughout admins navigation of the site 
Frequency of Use: Admin users may create appointment blocks periodically
Channel to Actor: Main interface
Secondary Actors: None
Channel to Secondary Actors: None
Open Issues: 

### Use Case: View User Appointments
Primary Actor: Admin User
Goal in Context: The goal is to allow admin users to view the appointments of registered users. Admin users can access user appointment information for administrative and support purposes.
Preconditions: Admin is registered and there exists user appointments in the system
Trigger: The admin user initiates the action to view user appointments from the Admin interface
Scenario: 1) Admin logs on 2) admin interface is displayed 3) Admin navigates to view user appointments section 4) system provides the admin user with appointments made by users 
Exceptions: No admin privileges, or no appointments have been made
Priority: High
When Available: throughout admins navigation of the site
Frequency of Use: Admin users may need to view appointments periodically to accordingly schedule help
Channel to Actor: Admin interface
Secondary Actors: none
Channel to Secondary Actors: none
Open Issues: 1) data privacy; only certain details should be displayed

### Use Case: View Feedback
Primary Actor: Admin User
Goal in Context: The goal is to allow admin users to view feedback and reviews submitted by users of the appointment-based system. Admin users can access this feedback to gain insights into user satisfaction, identify areas for improvement, and provide support.
Preconditions: Admin is registered in the system and users have submitted feedback
Trigger: The admin user initiates the action to view feedback from the Admin interface
Scenario: 1) Admin logs on 2) admin interface is displayed 3) admin selects view feedback option from the nav bar. 4) feedback is displayed by users 
Exceptions: No feedback has been provided 
Priority: High
When Available: throughout admins navigation of the site
Frequency of Use: Admin users may view feedback as needed for monitoring user satisfaction, providing support, and making improvements.
Channel to Actor: Admin Main interface
Secondary Actors: None
Channel to Secondary Actors: None
Open Issues:

### Use Case: Provide Wait Time Parameters
Primary Actor: Admin User
Goal in Context: the goal is to allow admin users to define and manage parameters related to the calculation and presentation of estimated wait times within the appointment-based system. Admin users can customize these parameters to ensure accurate and useful wait time information for users.
Preconditions: The admin is registered in the system and has admin access
Trigger: Admin user initiates the action to provide and manage wait time parameters
Scenario: 1) Admin logs on 2) admin interface is displayed 3) admin selects “Wait Time Parameters” from the nav bar. 4) Admin enters parameters that will affect wait time 5) wait times are updated
Exceptions: Admin is not registered as admin
Priority:High
When Available: Throughout admins navigation of the site
Frequency of Use: Admin users may provide and adjust wait time parameters as needed to ensure the optimal operation of the appointment-based system
Channel to Actor: Admin main interface
Secondary Actors: None
Channel to Secondary Actors: None
Open Issues: 1) Considerations for what these parameter options should be are a part of the process to ensure that accurate and meaningful wait time estimates are provided to users
