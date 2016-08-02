#!/bin/bash

# Build project
npm run build

# Stage files
git checkout master  
git add . 
 
# Commit
read -p "Enter commit message: " desc
git commit -m "$desc" 

# Bump version?
read -p "Bump version? (y/n): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    printf "\nCurrent git tag: "
    git describe --abbrev=0 --tags
    read -p "Enter new version (tag): " version
    
    # Using mversion as cross packaging module version bumper. https://github.com/mikaelbr/mversion
    mversion "$version" -m

    # Update npm package
    npm publish
fi

# Push to master
git push origin master --tags

# Keep gh-pages branch up to date with master
git checkout gh-pages
git merge master
git push origin gh-pages --tags
git checkout master