# Installation Instructions 

1.  Make sure postgres is installed
2.  Make sure ruby is installed (ruby version 3.0.2 may be required)
3.  Make sure git is installed and setup
4.  Make sure rails is installed and setup 
5.  Some detailed installation insructions are shown below:
     -  Type which postgres
     -  If it says 14 then type:
         -  sudo yum install postgresql13-server postgresql13-libs postgresql13-devel --nobest
         -  Note: this will take a bit of time
         -  Change the .bash_profile to say 13 instead of 14 in the line near the end by doing vi .bash_profile
         -  Logout of the terminal 
     -  If it says 'no postgres found'
         -  Change the .bash_profile to say 13 instead of 14 in the line near the end by doing vi .bash_profile and double check that you have no spelling typos
         -  Logout of the terminal 
     -  Now open terminal again and type which postgres to ensure it worked
         -  You should see some like '/usr/pgsql-13/bin/postgres'
     -  Now we must clone the forked repository on github to our machine
         -  To fork, go to the github repository, click fork, set yourself as the owner, set it as private, remove any but yourself as collaborators
         -  To clone, type git clone followed by the ssh url of your github repository. This ssh url can be found by clicking the green code button on the repository. An ssh key must be set up from you machine to your github account for this to work. Instructions for how to do this can be found in the Setting_up_SSH_keys_GitHub.md that is also on this repository linked on the readme.md
         -  Once the repository is cloned to your machine migrate to the src folder inside the repository on your machine. Now type 'bundle install'.
             -  If it says: 'rbenv: version 3.0.2 is not installed', then type rbenv install 3.0.2 (note, it takes a little bit of time)
             -  Now run bundle install and it should work
             -  Run bundle update rails
          -  Tun all of the rake commands which includes rake db:drop, rake db:create, rake db:migrate, rake db:seed
          -  Now navigate to the src folder
              -  Start the server so the application can run
              -  This can be done by doing 'ip addr show eth0' to find your ip address
              -  After finding your ip address run tails server --binding=YOUR_IP_ADDRESS_HERE
              -  Now visit the application url and it should be up and running 
       

# Usage Intructions


1. Once on our application log in with a set account in the seeds file(dummy account) or sign up with a new account for a new use
2. Once logged in/signed up there will be a button for a page at the top called "Pre-register"
3. Press this button to be redirected to the Pre-registration form
4. Fill in all fields with proper/relevant information
5. Once all fields are filled in press the submit form button
6. For any clients that want to register members under their household, instructions will be shown on the pre-registration form page as a text box.
7. These instructions will say that members are filled in on the "my account" page
8. After submitting the form go to the my account page which will display your qr code and already filled in information
9. At the bottom click edit, this will allow you to edit any information that you would like to be changed
10. Also this edit button will display a new button at the bottom of the page that gives you the ability to add additional members
11. Once that button is clicked additional members can be added as desired
12. This is the instructions to use the pre-registration form and "my account" page module 

