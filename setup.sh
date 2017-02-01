#!/usr/bin/env bash

DATABASE_NAMES=("wealthsimple_development" "wealthsimple_test")
RUBY_VERSIONS=("2.1.5" "2.2.2", "2.2.3", "2.3.0", "2.3.1", "2.3.3", "2.4.0")
NODE_VERSIONS=("7.1.0")

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "==========Error: This script only works on OS X.=========="
  exit 1
fi

echo "==========Install & update Homebrew=========="
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
brew update

echo "==========Installing git and Heroku CLI =========="
brew install git heroku

echo "==========Allow us to create custom launch agents=========="
mkdir -p ~/Library/LaunchAgents

echo "==========Install Redis and start it on boot=========="
brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
launchctl start io.redis.redis-server

echo "==========Install PostgreSQL and start it on boot=========="
brew install postgres
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

echo "==========Installing Ruby prerequisites=========="
brew install openssl libyaml libffi
# Create symlinks for OpenSSL to prevent `error: 'openssl/ssl.h' file not found`
brew link --force openssl

echo "==========Install rbenv for Ruby version management=========="
brew install rbenv ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

echo "==========Install the Ruby versions we use=========="
for ruby_version in "${RUBY_VERSIONS[@]}"; do
  rbenv install $ruby_version
  rbenv shell $ruby_version
  gem install bundle
done
rbenv rehash

echo "==========Create postgres superuser=========="
createuser -s postgres

echo "==========Create databases and hstore extensions=========="
for database_name in "${DATABASE_NAMES[@]}"; do
  psql --username=postgres --command="CREATE DATABASE ${database_name};"
  psql --dbname=$database_name --command="CREATE EXTENSION IF NOT EXISTS hstore;"
done

echo "==========Install node.js and node version management tools=========="
brew install n
for node_version in "${NODE_VERSIONS[@]}"; do
  n $node_version
done
npm install -g avn avn-n
avn setup

echo "==========Install phantomjs 1.9.2=========="
# Phantomjs version 2.0+ is not yet supported by some gems (Poltergeist), and
# versions >1.9.2 fail on OSX versions later than Yosemite.
brew install homebrew/versions/phantomjs192

# 3 beep salute
for i in `seq 3`; do
    echo -ne '\007'
    sleep 0.5
done &
echo "✨ 💥 Done! 💥 ✨"
