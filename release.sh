#!/usr/bin/env bash

# Assuming you have a master and dev branch, and that you make new
# release branches named as the version they correspond to, e.g. 1.0.3
# Usage: ./release.sh 1.0.3

# Get version argument and verify
version=$1
if [ -z "$version" ]; then
  echo "Please specify a version"
  exit
fi

# Output
echo "Releasing version $version"
echo "-------------------------------------------------------------------------"

# Get current branch and checkout if needed
branch=$(git symbolic-ref --short -q HEAD)
if [ "$branch" != "$version" ]; then
  git checkout $version
fi

# Ensure working directory in version branch clean
git update-index -q --refresh
if ! git diff-index --quiet HEAD --; then
  echo "Working directory not clean, please commit your changes first"
  exit
fi

# Checkout master branch and merge version branch into master
git checkout master
var=$(git merge master --no-ff --no-edit 2>&1) 
echo var

# Success
echo "-------------------------------------------------------------------------"
echo "Release $version complete"
