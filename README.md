# setup.sh
First-time developer machine setup script.

This script assumes that:

1. your operating system is Mac OS X, and 
2. your default shell is bash (this should be the case for OS X)

## Step 1. Install prerequisite software

First, make sure you have Xcode command line tools (or Xcode) installed:

1. Open Terminal (Applications > Utilities > Terminal)
2. Type in `xcode-select --install` and press the Return key.

## Step 2. Run the setup.sh script

Open Terminal, paste in the following line, and press the Return key. It may take ~10 minutes to run:

    curl -fsSL https://raw.githubusercontent.com/wealthsimple/setup.sh/master/setup.sh | bash

## Troubleshooting

### OS X 10.11

If you get the error `configure: error: readline library not found` while installing Postgres, try running the following, and rerunning setup.sh afterwards:

    sudo xcode-select -s /Library/Developer/CommandLineTools

### PostgreSQL issues

If you get an error that Postgres is not running, try running the following commands:

    initdb -D /usr/local/var/postgres/data
    pg_ctl -D /usr/local/var/postgres/data -l logfile start
