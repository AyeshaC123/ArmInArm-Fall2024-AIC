# Arm In Arm Volunteer Application

## Project Proposal

1. Description of the problem to be solved.

Arm In Arm can seek to enhance the effectiveness of their volunteer coordination process to better align volunteers with tasks that maximize their skills and capabilities. Currently, the task allocation process presents an opportunity for improvement, as it involves significant manual effort and time consumption, diverting resources away from the organization's primary mission. This arises from the need for enhanced coordination and a structured approach to match volunteers with tasks that fully leverage their abilities. Consequently, there is room for enhancement to ensure that volunteers are consistently assigned tasks that align with their unique strengths and talents. Additionally, optimizing the allocation of volunteers based on their language proficiency is crucial to prevent inadvertent scheduling for language-dependent tasks. By streamlining volunteer assignments and ensuring they align with individual skills and abilities, Arm In Arm aims to enhance organizational productivity and efficiency, ultimately improving the overall experience for both volunteers and the organization's clients.

 2. Description of the objective of the proposed project to address the problem. 

The objective of our project is to create a more efficient volunteer organization system for Arm in Arm. We plan to create a web application that will ask potential volunteers to provide their skill sets, so that we can assign them to relevant roles and create a more effective system where each volunteer is clear about their tasks for the day. This will also allow Arm In Arm to better promote volunteer opportunities. 

3. Description of how the project will meet this objective. 

The project will meet this objective by assigning volunteers to roles that are most relevant to them. This will efficiently utilize the strengths of each volunteer as they will be helping in areas that they are most qualified and passionate about. It will also allow Arm In Arm to be able to better plan their days, as they will have a clear count regarding how many volunteers there will be for a specific day and what they will do. This will save time and is more efficient than assigning volunteers to different tasks each morning. It will also ensure that there isn’t a shortage or excess of volunteers for each day. 

4. Explanation of what aspect of the project is innovative, and why. 

This project is innovative as it matches volunteers with tasks that match their strengths in an efficient and optimizable manner. Compared to the organization’s current process, our project will assign volunteers to the roles that best fit their interests and strengths, increasing the efficiency of the workers and therefore better helping their clients. We are focusing on a specific inefficiency that we noticed at the organization and proposing a new solution to help the organization, making our project innovative.

5. Stakeholders of the project, and explanation of why it is important for the team to be in ongoing contact with them. 

The stakeholders in this project encompass a wide range of individuals and groups, including but not limited to clients, volunteers, fellow engineers, the organization itself, as well as the community at large. Effective communication with all stakeholders is vital as we embark on the development of this application. Our primary goal is to create a solution that aligns with the best interests and needs of these diverse stakeholders. Deviating from their interests or losing sight of the client's specific requirements could result in missing crucial features that are essential for the application's efficiency. Maintaining open and ongoing communication ensures a streamlined development process, prevents complications, and fosters collaboration between the development team and all stakeholders, guaranteeing that the end product serves the collective vision and purpose of the entire community.

6. Other similar systems and approaches that exist, and how your project is different from them. 

Within Arm In Arm, there is only a volunteer opportunities page which states the volunteer positions and at which locations. Our project will be beneficial to Arm In Arm as it will help to organize the volunteers into the correct positions as well as keep track of the amount of volunteers available on a given day. 

7. Course content, concepts, and technologies each team member will need to learn, and a plan with an estimated timeline for how this will be done. 

Each team member will learn how to use Ruby on Rails to integrate our web app. We will be using diagrams to communicate with stakeholders on what progress has been made and what our next steps to be implemented are as well. For our timeline we expect to first code our form and the algorithm necessary for sorting. We will do initial testing to ensure that the algorithm works correctly and how it is intended to. Next we will integrate a database to store our data from the form. Our final step will be to turn our code into a web application and test it to ensure that it is working.

8. A simple use case diagram showing the project functionality. Identify the functionality that will be implemented in each prototype and completed within the time constraints of the semester. Specify functionality that is beyond the semester scope but could be added in future versions.
The functionality that we will implement during the course of the semester is depicted in the use case diagram - we plan to create an application that will ask the user to enter their interests and they will be assigned to a task accordingly. For prototype one we will be setting up the classes needed for our application. In prototype two we will finish implementing our algorithm needed for the application’s volunteer organization with the ability to test through the ruby file. Prototype three will have our project linked to a database to store info as well as linking to a web interface for user interaction and making finishing touches.  Something that is beyond the semester scope is expanding our application to Arm in Arm’s other branches, but this could be implemented in future versions.

## Diagrams  
* [Use Case Diagram](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab13-prototype2/docs/Team13-use-case.md)
* [Use Case Descriptions](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab13-prototype2/docs/Team13-use-case-description.md)
* [Detailed Design Class Diagram](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab13-prototype2/docs/Team13-class-diagram.md)
* [System Sequence Diagrams](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab13-prototype2/docs/Team13-system-sequence-diagram.md)
* [Statecharts](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab13-prototype2/docs/Team13-state-charts.md)
* [Test Case Design](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab13-prototype2/docs/Team13-test-case-design.md)
* [UI Mockup](https://github.com/TCNJ-SE/ArmInArm-F23/blob/collab13-prototype2/docs/Team13-ui-mockup.md)


## Requirements and Analysis
The current changes made:
 - Created three html files insde app/views
  - _volfourm.html.erb -> Holding the questions to be asked to upcoming voluneteers looking for a position
  - _viewHours.html.erb -> Holding the signed in users current hours for their upcoming shift
  - Default.html.erb -> Holding the orignal index.html.erb file contents with helpful information
 - Edited the index.html.erb file and made our own homepage
 - Edited the the dropdown menus options - 'View Upcoming Volunteer Hours' page and 'Fill out Volunteer Form' page
 - Created controller files for the separate pages
 - Added text boxes to enter name/number, radio buttons to select interests, and submit button on the Volunteer Form page

## Design
The current changes made:
 - Created database to hold volunteers
 - Created an admin system to allow admin users to see all data and grant admin privilege to others
 - Added a home button on the web app
 - Volunteer form now stores data in database
 - Provided a summary of all volunteers in the database

## Team Code
[Team 13 - Team Code](https://github.com/TCNJ-SE/ArmInArm-F23/blob/36d672a073e17e99c57c15df7a808d8bef9c18a4/docs/Team%2013%20-%20Team%20Code)
