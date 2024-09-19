# Team 11 Installation / Usage Instructions

1. Follow the installation guide linked in docs to set up the VM.  Ensure PostgreSQL and Ruby/Rails are working before attempting next steps.
2. Clone the git repository on the VM.
3. Navigate to the src folder.  Run the following commands to set up the database:
   ```
   rake db:create
   rake db:migrate:reset
   rake db:migrate
   rake db:create
   ```
4. Run the following commands to start the server:
   ```
   ip addr show eth0
   rails server --binding=XXX.XXX.XXX.XXX
   ```
   Replace XXX.XXX.XXX.XXX with your IP address.
5. Navigate to http://csc415-serverXX.hpc.tcnj.edu:3000/ to view the webpage if on a personal VM, or http://csc415-teamXX.hpc.tcnj.edu:3000/ if on a team VM.  Otherwise, you can navigate to the page using XXX.XXX.XXX.XXX:3000.

## Our implementation instructions
1. Navigate to pre-registration in the navbar.
2. Register a household using the provided form (hover over the question marks to display tooltips).
4. Sign in as an admin account.
5. Navigate to review forms in the navbar.
6. Press review form to view the household, or press approve or deny to directly do an action.
7. On the review form page, press approve or deny to do an action, or press edit to make changes to the form before approving or denying.
