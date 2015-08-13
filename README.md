# setup.sh
First-time developer machine setup script.

# Step 1. Install prerequisite software

First, make sure you have the following installed on your machine:

1. Heroku Toolbelt: https://toolbelt.heroku.com/
2. Postgres: http://postgresapp.com/ (drag and drop it to your "Applications" folder)
3. Open up Postgres. Click on the icon in the status bar, go to "Preferences" and check the box to "Start Postgres automatically after login".

# Step 2. Install Xcode command line tools

Open Terminal (Applications > Utilities > Terminal), paste in the following, and press the Return key:

    xcode-select --install

# Step 3. Run the setup.sh script

Open Terminal, paste in the following line, and press the Return key. It may take ~10 minutes to run:

    curl -fsSL https://raw.githubusercontent.com/wealthsimple/setup.sh/master/setup.sh | bash
