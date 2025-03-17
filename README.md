# Alumni Tracker

## Introduction
This web application is a Ruby on Rails CRUD application that creates, edits, shows, and removes Sligh Health Alumni data.  
Three primary users consist of:
- **Admins**
- **Current members**
- **Alumni**  

Alumni input their information, which gets displayed within the application and becomes viewable to all users (i.e., current members and admins). Current members are able to search and view alumni based on certain criteria such as awards and career fields.

---

## Requirements
This code has been run and tested on:
- **Ruby** – 3.3.0p0  
- **Rails** – 8.0.1  
- **Ruby Gems** – Listed in `Gemfile`  
- **PostgreSQL** – 17.3  
- **Node.js** – v18.19.0  
- **Yarn** – 1.22.22  
- **Docker** – `rails-dev:latest`  

---

## External Dependencies
- **Docker** – [Download latest version](https://www.docker.com/products/docker-desktop)  
- **Heroku CLI** – [Download latest version](https://devcenter.heroku.com/articles/heroku-cli)  
- **Git** – [Download latest version](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  
- **GitHub Desktop** *(Optional but helpful)* – [Download](https://desktop.github.com/)  

---

## Installation
Clone the repository:
```bash
git clone https://github.com/KarlFarrar/alumni_tracker.git
```

## Tests
An RSpec test suite is available and can be ran using:
rspec spec/
You can run all the test cases by running. This will run both the unit and integration tests. rspec .
Execute Code
Run the following code in Powershell if using windows or the terminal using Linux/Mac
cd alumni_tracker
docker run --name postgres --network rails-net -e POSTGRES_PASSWORD=password -e POSTGRES_USER=postgres -d postgres:latest
docker run -it --name rails-app --network rails-net -p 3000:3000 -v ${PWD}:/app rails-dev bash
**NOTE: ${PWD} should be changed to $(pwd) for Mac users**
Install the app
bundle install && rails webpacker:install && rails db:create && db:migrate
Run the app rails server --binding:0.0.0.0
The application can be seen using a browser and navigating to http://localhost:3000/



## Environmental Variables/Files
We have environment variables setup for Authentication
Instructions
Include gem ‘dotenv’ into the gemfile 
Create a .env file 
Inside .env include…
GOOGLE_OAUTH_CLIENT_ID=<Your_Client_ID>
GOOGLE_OAUTH_CLIENT_SECRET=<Your_Client_Secret>
*Note do not include <>

## Deployment
For this assignment you should work with your github repository environment_test that you created previously. It should contain the test_app that we built in lab 1 and 2.
(Start your docker and work in your terminal) Make sure you have dev, test and main branches. However, since we’re not really going to develop any new features, we won’t be using the dev branch in the assignment. We’ll be using test and main branches. First, use $ git status to see if your git is tracking the current dir. If you haven’t created dev and test branches, please do it now. For example, commands to create a test branch with git:

Note: $ git checkout -b <branch> will create and switch to the new branch $ git checkout <branch> will only switch to the branch You don’t need to create a new branch in Github in advance, because $ git push origin <branch> will do it for you if Github doesn’t have a corresponding branch.
After you create all three branches, your Github should look like this:

Switch to the test branch. Command - $ git checkout test
We want to run the migration on each deploy automatically. Create a file named Procfile in the root dir with this line of code

Ensure a root route in config/routes.rb

Save the changes and push it to origin/test $ git add . $ git commit -m “add Procfile and route” $ git push origin test
From the Heroku Dashboard Click the New button in the top right of your app list and select Create new pipeline:

Note: if there’s no app in a pipeline, the pipeline will disappear. Therefore we need to configure some apps as default.
Enable Review Apps. Do NOT select any options for this assignment. Click “Enable Review Apps” right away.

Click “New app” in Review Apps. Choose the test branch. After you click “Create”, Heroku will start deploying immediately. Every time you make changes to the test branch, it triggers automatic deployment.

We also need to create an app for staging.

Click on the stage-test-app-1. Click Deploy. Choose the main branch for Automatic Deploys.

Great! You just created a pipeline ready for deployment!
Let’s make a small change to our app to see how Heroku pipeline works. You should remain in the test branch ($ git checkout test). You can be creative and change/add something that won’t break your app. For example, I add something into app/views/books/index.html.erb. Then save the changes and push to the remote test branch. Commands are the same as step 6. You’ll see that Heroku starts automatic deployment in the review app. After the deployment is done, open the app and see if it works.

Next, go to the Github website. Create a pull request and merge the changes from test to main
After the merge, you’ll see that Heroku is automatically deploying the staging app.

When the staging app is ready, open the app and check if everything looks good. Then promote it to the production area.

After your review app and production app are both deployed, take a screenshot of your pipeline interface. Include the screenshot and links to both apps in the submission report.

## CI/CD
CI/CD has been implemented in the GitHub Actions in the repo here -> https://github.com/KarlFarrar/alumni_tracker.git
## Support
The support of this app has been officially closed. There is nothing more important left to develop. For any questions or concerns with the application please contact karl.j.farrar@gmail.com
## Extra Helps

