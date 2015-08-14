#!/usr/bin/env bash

DATABASE_NAMES=("wealthsimple_development" "wealthsimple_test")
RUBY_VERSIONS=("2.1.5" "2.2.2")

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
for database_name in "${DATABASE_NAMES[@]}"; do
  psql --username=postgres --command="CREATE DATABASE ${database_name};"
  psql --dbname=$database_name --command="CREATE EXTENSION IF NOT EXISTS hstore;"
done

# Install rbenv for Ruby version management
brew install rbenv ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# Install the Ruby versions we use
for ruby_version in "${RUBY_VERSIONS[@]}"; do
  rbenv install $ruby_version
  rbenv shell $ruby_version
  gem install bundle
done
rbenv rehash

echo "✨ 💥 Done! 💥 ✨"
