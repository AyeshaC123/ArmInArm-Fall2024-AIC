# Installation and Usage Guide

This document outlines the necessary steps for installing and utilizing this project effectively.

## Ensure your system meets the following requirements before starting the installation:
- **Ruby**: Version greater than 2.0.0
- **Rails**: Version 7.1.3.2
- **PostgreSQL**: Version 14.11

## Installation Process
Follow these steps to set up the project on your machine:

**Clone the Repository**
    
   - Visit the repository's GitHub page, click on the "Code" button, and choose your preferred cloning method (HTTPS, SSH, or GitHub CLI).
   - Open a terminal and run:
     ```
     git clone [repository-url]
     ```
   - Navigate to the repository directory:
     ```
     cd repository-name
     ```
   - Verify the directory contents:
     ```
     ls
     ```

 **Install Dependencies**
   - Install Ruby gems: bundle install
   - Install JavaScript packages: yarn install
     

## Set up the database with: 
    Turn all of the rake commands which includes rake db:drop, rake db:create, rake db:migrate, rake db:seed
     

4. **Launch the Application**
   - Find your VM's IP address:
     ```
     ip addr show eth0
     ```
   - Start the Rails server specifying your IP address:
     ```
     rails s --binding=xxx.xxx.xxx.xxx
     ```
   - Access the application through `http://csc415-team13.hpc.tcnj.edu:3000/`.

## Usage
After installing the application, you can use it by going to pre registration page and to do thar 

- **Pre-Registration:**
  - sign up and log in 
  - Navigate to the Pre-Registration section on the website .
  - Complete the registration form accurately. enter address, head of household name and members in household
  - add additional members and relationship to the head of household 
  - if head of household already has registered than it won't let other members register as only one member per family should sign up. 
  - user will also have access to view other members in household 

This guide aims to facilitate the setup and operation of the application, ensuring you can efficiently register and interact with the system.
