# README

# README

### Team Guidelines:
[Team Code](https://github.com/TCNJ-SE/ArmInArm-F23/blob/cd8ab52b797cbe58af846f47ced510cdc292da74/src/Team_21_Team_Code.md)

# Appointments_With_Wait_Time



### This project will be implementing a appointments system that will allow clients to schedule a time they want to come to arm in arm to pick up food. This appointment system will allow for the creation, deletion, and viewing of appointments. When you view an appointment you will also be able to see an estimated wait time display. These wait times will be calculated using data from Arm-in-Arm about their processing times, and the number of users who have already pre-registered for certain times. In doing this, the number of people coming to arm-in-arm should be spread out throughout the day.
* 

1. Description of the problem to be solved. 
The current wait times for people getting food from the different arm and arm locations are not optimal. Having long lines or long wait times to get food causes problems in the community when families just want to come in and get their food and leave. 
2. Description of the objective of the proposed project to address the problem.
Our objective will be to create an appointment system that will allow people who want to get food to be able to get their food in a timely manner. We also want to integrate an estimated wait so that people who do have appointments can know how long they might have to wait to get service.
3. Description of how the project will meet this objective.
The project will meet the objective by splitting different aspects of the project between team members while getting input from Arm in Arm to make a coherent product.
4. Explanation of what aspect of the project is innovative, and why.
The estimated wait time portion of the project is innovative because it would help both people who make an appointment and those who don’t make an appointment make decisions on the best time to come to the different arm in arm locations. This could drastically lower lines and improve the system vastly.

8.The first prototype will allow registering users to log in or create an account, create appointments, view appointments, and cancel appointments. The first prototype will also allow the admin users to log into their account and enter an admin dashboard. The Second prototype will allow admin users to create the appointment blocks registering users will be able to use. Admin users will also be able view made user appointments and any user feedback that is given. In our third prototype we will give the registering user the ability to see past appointments, view wait time for the appointments, and allow admin users to provide wait time parameters that will change the wait time calculation for users with appointments.




Updated use case diagram : 
<img width="481" alt="image" src="https://github.com/TCNJ-SE/ArmInArm-F23/assets/106837490/a2b59f27-03f4-4c78-9c35-fabd8e65ba85">


Changes and implementations for prototype 2:
  -Made the ability to create, edit, destroy, and show appointments.
  -Made an admin view to view user appointments
  -Created a colorblind view
  -Began work on the wait time controller
  -Improved the wait time graph mockups
What needs to be done
  -Integrate with group 14
  -Styling
  -Wait time controller and algorithms
  -Ensure that people can only make one appointment in a week.


How will we as a group perform user testing?: 
Accessibility Testing: involving users with various disabilities to interact with the UI and evaluate the system's accessibility features.

A/B testing: Two different UI’s can be given to users and the users can explain which interface they found easier to navigate.

How can we as a group raise interest in this project?
  Our group could label working on the project as community service to encourage others in the community to contribute to it. Also, just leaving behind really clear instructions and documentation will help others to get into the project more easily and make the project itself more accessible to contribute to. The project can also be talked about on Arm-in-Arm’s media pages in order to showcase the project to others who might want to contribute to their cause.
  
### Developed by TCNJ Software Engineering Students for Arm In Arm
  * [Setting up SSH keys with GitHub](docs/Setting_up_SSH_keys_GitHub.md)
  * [Setting up the correct database](docs/SQLite3_to_Postgres_on_Rails.md)
* [More helpful information](docs/More_helpful_info.md)
* [Guide to the .gitignore file](docs/.gitignore_Guide.md)



### Project Name: Client Profile:
### An engaging description of the project, including how and why it will add value to extant understanding of the project:
    Our project will involve creating a software system that allows clients of Arm In Arm to create individual client profiles that hold client specific data that is valuable for Arm In Arm volunteers to use when crafting a client’s bag. Data such as a client’s food preferences, allergies, dietary restrictions and data pertaining to a client’s household all are valuable for volunteers when enabling the best experience for clients. Clients can also update,delete and modify these profiles to ensure data correctness and validity. By being able to have easy to reference information about clients, there will be less guess work on Arm In Arm’s part about their client’s needs. Instead there will be more confidence from Arm In Arm that they are sufficiently serving their clients as well as clients feeling valued and understood by the Arm In Arm staff. Client Profiles would limit the issue of long lines and increase client safety but allow clients to simply come in, give the volunteer their name and receive their personalized bag. This would also lessen disorganization within Arm In Arm through that come-and-go process, giving the staff ample time to pre-build bags and allow for more efficiency. Our project goes beyond creating profiles, it redefines the experience for clients choosing to come to Arm In Arm. We recognize that every individual has unique needs and preferences, especially when it comes to building a grocery bag for a client and their families. Our software will offer a seamless way for clients to get the most out of their weekly grocery bags through individualized client profiles. Admins will be able to search for a client's data by a client identifier which is client ID, first name and last name. 

# Team 22 - Pre-registration module and QR code generator

>  The project that Team 22 will be designing is a pre registration system for Arm in Arm clients, which will allow clients to be identified quickly and easily when picking up food from an Arm in Arm location. This application will be based on a set of questions Arm in Arm has provided for us. We will use the questions to create an online form in a way. This online form will allow applicants to register as an Arm in Arm customer from a remote device as opposed to going in person and getting asked these questions face to face. This will save Arm in Arm a lot of time and resources to register an applicant into the system. In terms of the user (applicant) that uses this application, we will implement it in a way that it is easy and straightforward to use. This way they can sign up as soon as possible, and receive the proper help they need. Once the user fills out this form they will be generated an id and more that is associated with all of their personal information. They can use this id to identify themselves at food pickup locations, so they can receive their food fast. Arm in Arm has already stressed the more people that are pre registered the faster the line moves at pickup locations. Our goal is to increase the number of applicants that can pre register online assuming they have access to a remote device. The user's newly entered information will be held in a database where Arm in Arm can access it whenever it is needed. Overall this should not completely resolve the issue of non registered customers showing up to locations and asking for food, but the goal is to lessen that number. We hope to make Arm in Arm’s life easier with this application!

# Team 21 -Admin panel, and Wait time Graph
    In order to address the overcrowding in the early morning hours, Team 21 has decided to design a system that will allow users to create appointments, and then display a graph that will show an estimated wait time for those appointments.  Hopefully, through use of this system, Arm-in-Arm's recipients will feel more comfortable registering for appointments, or choosing to come at a time when the pantry is less busy.  The basic layout is that any user can view how busy any Arm-in-Arm location is on the current day, and/or they can choose to sign up, register as a client, and then continue creating appointments for what is most convienient to them.  Site admins can also change the parameters of how long it takes the site to open, when the site is open, how long the appointment window is, and the length of time it takes to service people.  

# SE Rails starter
### A discussion of the social, ethical, economic and the real world issues that must be addressed for the project to deliver value, and how the team will do this:
    By moving Arm In Arm’s clientele to our software, several issues must be addressed and have been communicated within our team. We understand a majority of Arm In Arm’s clients may not speak or understand English and would be disadvantaged due to a language barrier. For that we have implemented a way for our software to include a drop down menu that allows the users to choose which language our project should conduct in. We have chosen English, Spanish, Creole and French as those were the languages we observed from our previous visit. Our project directly relates with data handling and management, and this can be concerning to many users. The issue of ensuring privacy for secure data is one we make sure to keep in mind as we build our project. Our group thought of utilizing a 2 factor identification system to ensure that the user logging in and getting access is the correct user to do so. This will allow clients to feel more safe about inputting sensitive information as well as prevent any security data leakage. We will also implement a saving functionality to ensure none of the data inputted by the client will ever be lost. We must practice a high degree of confidentiality in order to satisfy the concerns of the clients regarding their information and data privacy. The software should reveal information on a need-to-know basis and with the consent of those whose information is being recorded and revealed. Additionally, our software should be accessible to clients and should take caution not to discriminate intentionally or unintentionally. Accessibility for clients would mean accommodating language barriers; no client should be excluded from this system due to not speaking a “required language”. Taking caution to not discriminate with this system would mean ensuring the system does not inherently discriminate against any demographic groups based on how the software is designed. For example, the software should not inherently be unusable or exclude people of certain nationalities or different age groups. We plan on crafting our system to be very inclusive and accessible through our language preference and food preference options.


## Update Use Case Diagram
![UseCaseIV](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab12-prototype2/docs/UseCaseIV.jpeg)



## System Sequence Documents
* [CreateClientProfileSSD](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab12-prototype2/docs/CreateClientProfileSSD.jpeg)
* [ModifyClientProfileSSD](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab12-prototype2/docs/ModifyClientProfileSSD.jpeg)
* [SavingClientProfileSSD](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab12-prototype2/docs/SavingClientProfileSSD.jpeg)
* [SearchClientProfileSSD](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab12-prototype2/docs/SearchClientProfileSSD.jpeg)

## State Diagram
* [StateDiagram](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab12-prototype2/docs/StateDiagram.jpeg)
# Arm In Arm Project

### Developed by TCNJ Software Engineering Students for Arm In Arm
  * [Setting up SSH keys with GitHub](docs/Setting_up_SSH_keys_GitHub.md)
  * [Setting up the correct database](docs/SQLite3_to_Postgres_on_Rails.md)
* [More helpful information](docs/More_helpful_info.md)
* [Guide to the .gitignore file](docs/.gitignore_Guide.md)
* [Code of conduct for this community](CODE_OF_CONDUCT.md)
* [Installation and usage instructions](docs/Installation_Guide.md)
