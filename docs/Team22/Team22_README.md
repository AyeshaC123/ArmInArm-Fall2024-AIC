# Team 22 README: ArmInArm Application
## Contribution & Guidelines Documentation: Opensource Maintenance and Communication
* [Contributions_Guidelines](Team22_Contribute.md)
## Code of Conduct
* [Code_Of_Conduct](Team22_CodeOfConduct.md)
## Introduction
This project is designed to enhance the efficiency and effectiveness of Arm in Arm, a food distribution pantry. The project aims to help improve Arm in Arm staff members ability to view current client's information and household information, and view and add/edit current pantry location's information. Also, to allow current non-admin users to view their person client and household information as well as view the current pantry locations addresses and hours.

## Problem
The problem we are solving pertains to the overall structure and accessibility of information regarding the client and household lists and the Arm In Arm locations themselves. As it stands, there needs to be an efficient and reliable way for the Arm In Arm staff to access and update client, household and location information.

## Objective
We propose to create functionality that will allow Arm In Arm staff to update client credentials and change information regarding a location's opening/closing times and addresses if necessary. Our objectives include making an easily navigable webpage that displays all desired content in an organized manner.

## Description
The end goal of our application will incorporate improvements to user and admin pages. In the admin dashboard, users will be able to access client, household, and pantry location information. The admin will be able to view and and edit client and household information and pantry location information. They will be able to use different sorting functions to view households based on specific criteria, search for specific data, sort data, download data, and upload data. On the client side, users can only view client, household, and pantry locations' information and cannot edit information. 

## Stakeholders
The primary stakeholders include the Arm In Arm staff/volunteers, the clients who will be creating accounts and utilizing our website, and us as the developers. 

### Importance of continued contact with company
It is important to keep in contact with the company/organization so that we understand what their requirements are. It is not uncommon for requirements to change abruptly, especially if the organization thinks of new ideas that they wish to have implemented. Of course, part of keeping in touch with the company/organization is letting them know what is or isn't feasible given their budget and in our case, our timeframe. Additionally, it is important to inform the company/organization about the development process. Software engineers should be updating their clients on their progress to let them know that work is being done. Without communicating in this aspect, their clients might not be sure whether or not their money is being put to good use.

Our intention is to consistently communicate with Arm In Arm staff every time we update the project significantly. This would let them see and track our progress, allowing them to feel like they are part of the development process.

## Class Diagram
[Class Diagram](Team22_designs/Collab22-ClassDiagram.png)

## Use Case Diagram
[Use Case Diagram](Team22_designs/Collab22-UseCase.png)

- Prototype 1: Create basic UI and link it to database
- Prototype 2: Add more sophisticated features to the UI such as filtering results and searching for results, and displaying results
- Prototype 3: Address any bugs encountered in the program and ensure that it is robust before committing as final project
- Final Project: Make UI visibly more pleasing and easier to use
- Future Implementation: Limit number of results per page and allow to navigate multiple pages, Customize columns that are visible, Make working design for multiple devices

## Ethical, Legal, and Security Concerns

Implementing measures like two-factor identification for security.
Legal compliance with food bank regulations and data protection laws.
Regular security reviews and updates.
Backup and Recovery
The system will include functionalities for generating printable backups and exporting data in common formats, ensuring data security and accessibility.

### Social Issues
The social issue we are addressing is hunger, specifically in Mercer County. Throughout the state (not only Mercer County) families are struggling to provide for themselves and their families due to many factors. The volunteers and staff at Arm In Arm are driven to provide food and care to those who are in need of help. Our job is to aid Arm In Arm so that they can provide for individuals who are suffering from hunger. 

### Ethical Issues
The majority of the ethical issues surround data collection and presentation. There is sensitive information within our databases, including addresses, names, and financial status. It is imperative that we keep this data secure so that no one who is unauthorized to view certain information can access it. If not, it places the clients of Arm In Arm at risk. Another ethical issue could arise from not providing a way to translate our pages into multiple languages. Doing this would ensure that we are not catering to the needs of just one specific demographic of people. Allowing everyone regardless of preferred language to easily access our web pages will ensure that we are implementing ethical practices when developing our software.

### Economic Issues
Economic challenges are perhaps the most influential factor contributing to hunger in Mercer County, and possibly in all of New Jersey. Families are not able to afford healthy food or food at all, so they resort to eating quick meals like fast food or not at all. With many families, there is a degree of stress that comes with trying to pay bills and taxes while also paying for food. Arm In Arm helps alleviate some of this stress by providing food for those who are struggling financially. In developing software to help Arm In Arm, we are indirectly helping families who may be struggling to put food on the table.

### Security & Privacy Concerns
Due to the nature of the information stored in the databases (sensitive information including names, addresses, and financial information) it is important to limit access to authorized users only. This may be accomplished by including checks such as ensuring that the user is signed in and has appropriate permissions. Furthermore, we need to ensure that these values are not able to be modified without the explicit command of a staff member to ensure that the values are not fraudulent.

## Future Scope and Enhancements
While the initial implementation focuses on core functionalities, future versions can expand to implementing a language change bar to accommodate for different user preferences.

## Conclusion
This integrated solution aims to significantly improve the service delivery process at Arm in Arm, benefiting clients, volunteers, and staff through streamlined scheduling, pre-registration, and volunteer coordination. The project's success hinges on effective implementation, regular updates, and a strong focus on user accessibility and security.


## Collab 22 Implementation
### Household List Admin Page
Admin page that allows admins to view, search, sort, download, & upload data specific household information that is displayed in a table
- Search form: allows to search for specific type of households
- Clear Search Results - clears the page & resets table
- Edit household entry
- View household entry
- Delete household entry
- View members of household
- Sorting feature - allows user to sort table in ascending/descending order based on a specifc data type
- Download feature - allows user to download csv file of table information
- Upload Feature - allows user to upload a csv file of exisiting households
### Client List Admin Page
Admin page that allows admins to view client information that is displayed in a table
- Sorting feature - allows user to sort table in ascending/descending order based on a specifc data type
- Edit client entry
- View client entry
- Delete client entry
## User's My Account Page
Each user will have their own account page that lists their client information, household information, & their unique QR code to their household info
- Allows user to edit client info, but NOT household info (only admins can edit household info)
### Locations Admin Page
- Allowed admin to edit the following information regarding the Arm In Arm pantry locations
    - Location Name
    - Location Address
    - Location Operating Days
    - Location Operating Hours
- Allowed the admin to confirm these changes
- Allowed to delete a location
- Allowed to create a new location
### Locations Client Page
- Allows regular users to view the pantry locations they can visit