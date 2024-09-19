# Installation & Usage Instructions 
### This document provides the instructions necessary for installing and using this project 

## Prerequisites 
Before installing, ensure you have the following software installed: 
- Ruby [ensure that your VM has a Ruby version > 2.0.0]
- Rails [version 7.1.3.2]
- PostgreSQL [version 14.11]

## Installation 
To instsall the project, follow these steps: 
1. Clone the repository 
   - Go to the GitHub page for the repository you want to clone and click on the green "Code" button, then choose either to clone using HTTPS, SSH, or GitHub CLI,  depending on your setup and preferences. 
   - Open a terminal window on your computer and use `git clone` command followed by the URL you just copied. 
        - `git clone [repository-url]`
   - After cloning, a new directory will be created with the same name as the repository. Navigate into it by using `cd repository-name`. 
   - Check the cloned repository files by using `ls` command. 

2. Install dependencies 
   - 'bundle install' 
   - 'yarn install' 

3. Set up the database 
   - Run the following commands to create databases and perform migration 
      - rake db:create 
      - rake db:migrate:reset
      - rake db:migrate
      - rake db:seed

4. Run the app 
   - Find the VM's ip address by typing this command: `ip addr show eth0` 
   - Run the server by typing this command: `rails s --binding xxx.xxx.xxx.xxx`
     - Before you type this command, ensure that you are in the `src` folder 
   - Access the application at http://csc415-team12.hpc.tcnj.edu:3000/ 


## Usage 
After installation, you can use the application as follows: 

- Pre-Registration: 
  - Navigate to the Pre-Registration section on the webiste and sign in to complete the registration form 
  - Input the required information into the form
    - If incorrect information is entered, error messages are prompted, and the input box is highlighted in red to indicate where the incorrect information has been entered 
 


 


