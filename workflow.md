# Dev Workflow

This document outlines how to contribute changes to the codebase

## Creating a Git Branch

The "master" branch will always be the true, current version of the application that should be running on the production server at any given time.  To make changes, first follow the [Setup](setup.md) instructions, then perform the following steps:

### 1. Creating a new branch

BEFORE making any changes, make sure you're on the latest master branch, then create a new branch for your new changes:

`cd "path/to/your/preferred/directory"`

`git pull origin`

`git checkout -b name-of-your-new-branch`

`git branch --set-upstream-to origin`

### 2. Make your Changes

Now make your changes.  After you're ready to publish your changes, commit your changes to your local branch:

`git add -A`

`git commit -m "Give a description of what changed here"`

`git push origin`

### 3. Create a Pull Request

Congrats! You've pushed your local branch to GitHub, but it's not merged into the master branch yet!  To do that, you need to get approval from at least 2 other people on the project.  You can do this by logging into GitHub, finding your branch in the project and clicking "Create Pull Request".  Create the request and add a good description of what you're changing, then add whichever project members to the request that makes sense.  After getting approved, hit the Merge button that appears and update the Dev Server by logging into it and running:

`cd /opt/CodeAndLearn`

`git pull origin`

TODO: Add instruction to restart Python web server