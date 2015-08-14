#!/usr/bin/env bash

# Install & update Homebrew
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
brew update

# Allow us to create custom launch agents
mkdir -p ~/Library/LaunchAgents

# Install Redis and start it on boot
brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
launchctl start io.redis.redis-server

# Install PostgreSQL and start it on boot
brew install postgres
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

# Create postgres superuser
createuser -s postgres

# Create databases and hstore extensions
psql --command="CREATE DATABASE wealthsimple_development;"
psql --dbname=wealthsimple_development --command="CREATE EXTENSION IF NOT EXISTS hstore;"
psql --command="CREATE DATABASE wealthsimple_test;"
psql --dbname=wealthsimple_test --command="CREATE EXTENSION IF NOT EXISTS hstore;"

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

echo "✨ 💥 Done! 💥 ✨"
