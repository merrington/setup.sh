# setup.sh
First-time developer machine setup script.

# Step 1. Install prerequisite software

First, make sure you have the following installed on your machine:

1. Heroku Toolbelt: https://toolbelt.heroku.com/
2. Postgres App: http://postgresapp.com/

Note: after installing Postgres App, open it up (it appears in the top right of status bar), go to "Preferences" and check the box to "Start Postgres automatically after login".

# Step 2. Run the setup.sh script

Open Terminal.app (Applications > Utilities > Terminal), paste in the following line, and press the Return key. It may take ~10 minutes to run:

    curl https://raw.githubusercontent.com/wealthsimple/setup.sh/master/setup.sh | bash
