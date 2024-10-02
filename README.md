## ArmInArm
### Project Overview

The ArmInArm Appointment Scheduling System is designed to address scheduling issues faced by Arm In Arm, a food distribution pantry. The goal is to reduce confusion and improve attendance by providing a system that reminds clients of their appointments. This system will enable staff to track attendance more effectively and manage food distribution more efficiently.

### Problem Statement

Currently, clients miss appointments, leading to chaos and inefficiencies in food distribution. Arm In Arm staff need a way to better manage appointment attendance and food tracking.

### Objective

The system will notify clients of their appointments via reminders sent the day before their scheduled time. This will help reduce missed appointments, improve organization, and allow staff to track attendance and food distribution more accurately. The long-term goal is to improve client attendance and streamline operations.

### Features

1. Notification System: Sends reminders to clients about their upcoming appointments.
2. Admin Dashboard: Allows staff to view, edit, and manage client, household, and pantry location data.
3. Client Page: Clients can view their information, household details, and pantry location hours.
4. Reports: Generate attendance reports for staff to evaluate and improve appointment scheduling.
5. Security: Protects sensitive client data and ensures privacy.
Stakeholders

Arm In Arm Staff and Volunteers: The primary users who will manage appointments, track attendance, and oversee food distribution.
Clients: Individuals receiving services from Arm In Arm, benefiting from the improved appointment system.
Future Enhancements

Customizable Reminders: Allow clients to choose how far in advance they receive notifications.
Rescheduling Integration: Automatically send updates when appointments are rescheduled.
Notification Effectiveness Reports: Generate reports to evaluate the impact of reminders on attendance.
Ethical and Real-World Considerations

Security & Privacy: Protect client data such as names, addresses, and financial information.
Social and Economic Impact: Aid in alleviating hunger in Mercer County by improving food distribution processes.

### Setup/installation

# ArmInArm-Spr24 Source Code Setup

## How to Run

**In terminal:** `rails s --binding=10.18.6.55`

1. Check your IP address:

    ```bash
    ip addr show eth0
    ```

2. Start the Rails server:

    ```bash
    rails s --binding xxx.xxx.xxx.xxx
    ```

## Technology Stack

- **Frontend:** HTML, CSS, JavaScript
- **Backend:** Ruby on Rails
- **Database:** PostgreSQL
- **GitHub:** version control 

### Technology Versions

- Ruby: 3.0.2
- Postgres: `/usr/pgsql-14/bin/postgres`
- HTML: 5

## Getting Started

To get started with ArmInArm-Spr24, follow these steps:

1. Clone this repository.
2. Install dependencies using `bundle install`.
3. Set up the database with `rails db:create` and `rails db:migrate`.
4. Start the Rails server with `rails s --binding=10.18.6.55`.

## Install Ruby

You can use the following script to install Ruby:

```bash
./installruby.sh
```
### If you have any issues with installation, contact peer mentor : chaudha1@tcnj.edu
