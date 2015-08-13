#!/usr/bin/env bash

# Install Homebrew
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

# Install Redis and start it on boot
brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
launchctl start io.redis.redis-server

# Install rbenv for Ruby version management
brew install rbenv ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# Install the Ruby versions we use
rbenv install 2.2.2
rbenv install 2.1.5
rbenv shell 2.2.2
gem install bundle
rbenv shell 2.1.5
gem install bundle
rbenv rehash

# Add postgres binaries to PATH
echo 'export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin' >>~/.bash_profile
source ~/.bash_profile

# Create postgres superuser
createuser -s postgres

# Create databases and hstore extensions
psql --command="CREATE DATABASE wealthsimple_development;"
psql --dbname=wealthsimple_development --command="CREATE EXTENSION IF NOT EXISTS hstore;"
psql --command="CREATE DATABASE wealthsimple_test;"
psql --dbname=wealthsimple_test --command="CREATE EXTENSION IF NOT EXISTS hstore;"
