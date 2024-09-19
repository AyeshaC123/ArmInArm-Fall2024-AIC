# **Arm in Arm Collab Group 21, Spring 2024**
## This project is designed to aid the staff, volunteers, and clients of the Arm in Arm program
## This project was created by students of The Collage of New Jersey, Software Engeering Class

## Guidelines for future collaborators
Please read the following guidelines for future collaborators after familiarizing yourself with the goals of this project ([Visit the README](README.md)).
### Issues and bugs
Future collaborators should create issues and milestones on GitHub that have descriptive names. They are also encouraged to make use of the project board to communicate with fellow collaborators and stay organized. 
### Code contributions
1. Clone the repository
2. Create a new branch that is clearly labeled with the issue/new addition which the collaborator will address
3. Implement the necessary changes using good coding practice (see the below section for more details)
4. When complete, open a pull request to the main branch and include a lengthy description of any changes made to existing files and/or any new files created
### Accepted code
Accepted code is **efficient**, **modular**, **reliable**, and **secure**.
Additionally, collaborators must document their code through the use of comments, including descriptions for each function or important block of code and a header which must include the name of the file, a description of the file's contents and purpose, and the date on which the file was edited last.

## Design principles of this project are as follows 

**Affordance:** All buttons on the design are clearly labeled with their purpose (i.e. “Generate”). Additionally, the calendar icons on the fields for the graph generation indicate that the user is supposed to select dates, the check boxes indicate that the user can select multiple options, and the radio buttons suggest that the user can either select a bar graph or a pie chart, but not both.

**Visibility:** All of the options for user input for report and graph generation will be seen immediately at the top of the screen so that the users will not have to navigate to and from a report/graph display page and generation options page.

**Consistency:** The statistics, reports, and graphs page will all include the same nav bar at the top of the screen with every link in its original position, unchanged. Furthermore, the controls for generating a report/graph will be similar (selecting dates, showing households, showing adult clients, showing child clients, quick selection, and the generate button). Note: this has not yet been implemented for the report generator. 
Shortcuts for frequent users: For graph generation, users will be able to select a preset period of time (i.e. last week), instead of manually selecting the corresponding dates.

**Informative feedback:** The user will be able to view the report/graph immediately after they press the generate button. Additionally, after pressing the export button and selecting a file type, the user will (eventually) receive a message indicating that the file is being downloaded.

**Dialogs to yield closure:** The user will be able to see successful completion of their requests based on the changed report/graph. The values in the blue badges at the top of the reports page will reflect differently based on the user’s input. Similarly, the content of the graphs will vary based on the user’s input.

**Simple error handling:** In the case that no information matches the user’s conditions (i.e. no visits at a certain site within the past day), the report/graph generator will display a “No data” message. Additionally, there are bounds to the dates the user is able to input (e.g. they cannot select dates in the future). We intend on displaying an error dialog if the user inputs an end date that occurs before a start date as well.

**Easy reversal of actions:** Users will be able to change the series of input they used to generate a report/graph even after the report/graph has been generated. 

**Internal locus of control:** Users will have the ability to customize the format of the reports and graphs to their liking (i.e. display a certain time frame, display a certain type of client, display a specific location). Additionally, users will have the option to view the data as a bar graph or a pie chart.

**Reduce short-term memory load:** By displaying the report or graph on the same page where the user selects conditions for the report/graph, users will not have to remember the set of input they used to generate the report/graph. 


## **Future Growth**
This project is intended to be expanded apon by future developers. These developers could be future TCNJ SE students, public volunteers, programmers, and social innovators. We encurage anyone with the skills and drive to use our project as a stepping stone to futher help the Arm in Arm group, so that they may reach and help 
as many people as possible.

# ArmInArm-Spr24 Source Code Setup

**The full path to VM source code:** `/home/student4/collab21_work/ArmInArm-Spr24/src`

**Site:** [http://csc415-team21.hpc.tcnj.edu:3000](http://csc415-team21.hpc.tcnj.edu:3000) (adjust port# as needed:xxxx)

## How to Run
**Dir:** `/home/student4/collab21_work/ArmInArm-Spr24/src`

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

## File Path 

- `/home/student4/collab21_work/ArmInArm-Spr24/src`

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


