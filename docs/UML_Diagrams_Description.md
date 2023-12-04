# UML Diagram and Descriptions

## Use Case Diagram

<img width="525" alt="Screen Shot 2023-10-12 at 11 23 18 PM" src="https://github.com/TCNJ-SE/ArmInArm-F23/assets/135146869/e968f92f-e5c6-4895-99a7-eec5b733e273">


## Use-Case Descriptions


**Use Case:** 		Book appointment

**Primary actor:**	Client, Administrative User

**Goal in context:** 	To book an appointment for the food pantry at a specified time slot.

**Preconditions:** 	The user must be signed in to a client or admin account.

**Trigger:** 		The user selects the “make appointment” option.

**Scenario:**

1. The user selects the date and time for their appointment.
   
3. The user chooses the recurrence that suits the client’s needs, such as one-time, weekly, or bi-weekly slots.
   
5. The user submits the appointment request.

7. The system confirms the appointment and sends a notification to the client.

**Exceptions:**

1. _Unavailable time slot:_ The user tries to book an appointment for a time slot that is already full.

2. _Maximum number of appointments reached:_ The user tries to book more appointments than allowed.

---

**Use Case:** 		Edit existing appointment

**Primary actor:** 	Administrative User

**Goal in context:**	To manage existing client appointments.

**Preconditions:**	The user must be signed in to an admin account and navigate to the “generate schedule” page.

**Trigger:**		The user selects the “manage appointment” button.

**Scenario:**

1. The admin user views the client appointment selected.

2. The admin user chooses to cancel or makes edits to the existing appointment.

3. The admin user submits the edits or confirms the cancellation.

4. The system confirms the changes and sends a notification to the client detailing the changes made.

**Exceptions:**

1. _Unavailable time slot:_ The admin user tries to modify an appointment to another time that is already booked to its capacity, this will not work

---
**Use Case:**		View appointment schedule

**Primary actor:** 	Client, Administrative User

**Goal in context:** 	To view the list of appointments in the current schedule.

**Preconditions:**	The user must be signed in to a client or admin account.

**Trigger:** 		The user selects the “view schedule” button.

**Scenario:**

1. The user views the list of appointments they have access to. Clients have access to their own appointments while admin users have access to all appointments.

**Exceptions:**

1. _No appointments to view:_ The user does not have access to any appointments.

---

**Use Case:** 		Generate appointment schedule

**Primary actor:** 	Administrative User

**Goal in context:** 	To create a document with the current schedule listing all appointments.

**Preconditions:**	The user must be signed in to an admin account and navigate to the “view schedule” page.

**Trigger:**		The admin user selects the “generate schedule” button.

**Scenario:**

1. The admin user views the preview of the document.

2. The admin user confirms the generation of the PDF document.

3. The admin user downloads the document and saves it to their local machine.

**Exceptions:**

1. _No appointments to view:_ There are no appointments on the schedule.

---

**Use Case:** 		Send appointment updates

**Primary actor:** 	Client and/or Administrator 

**Goal in context:** 	To send appointment details as a reminder to the client.

**Preconditions:** 	The user must be signed in to a client or admin account and must have booked an available appointment.

**Trigger:** 		The user selects  the “confirm appointment” button after booking an appointment slot.


**Scenario:**

1. The user views their confirmed appointment.

2. The system sends a notification to the client using the contact they provided before booking their appointment

**Exceptions:**

1. _Invalid phone number:_ If the user did not provide a valid phone number, then they will be unable to receive this update.


## Analysis Class Diagram

<img width="425" alt="Screen Shot 2023-10-12 at 11 06 32 PM" src="https://github.com/TCNJ-SE/ArmInArm-F23/assets/135146869/ed6a4503-e23a-4eb4-a8cd-25fc2c38c64a">

