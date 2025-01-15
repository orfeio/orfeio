---
title: Git & GitHub Guide
layout: default
---

[Git](https://git-scm.com) is a version control system for tracking changes in your projects.

[GitHub](https://github.com) is a web-based hosting service for Git-managed projects, enabling collaboration on both public and private repositories.

This guide walks you through setting up Git, creating and managing a project, and collaborating with others privately using GitHub.

## Prerequisites

This guide assumes you have:
- A device running macOS, WSL, or Linux.
- A software project stored in a folder locally on the device.
- An account on [GitHub](https://github.com).
- Access to [an HPC environment](/condarc.html).

Paste each of the following commands into the Terminal app on your device.  

    { .note }
    The example prefix `cd ~/Downloads/software-project` for example commands may be omitted if the Terminal is already open to your software project's folder.  You can check by examining the output of the command `pwd`.

## Local Git

From a Terminal, set Git's defaults, initialize Git's tracking of the software project, and start committing changes.

1. Configure Git with your name and email.  This information will be available to anyone with access to the project.
    ```
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    ```
2. Open a Terminal to the software project's folder or directory and initialize Git's tracking of the project.  For this example, we will assume the project is in the Downloads folder and named `software-project`.
    ```
    cd ~/Downloads/software-project && git init
    ```
3. Create a `.gitignore` file in the `software-project` folder to exclude large datasets and secrets from tracking.  We will assume datasets are saved in the folder named `datasets` and secrets in a file named `.env`.
    ```
    cd ~/Downloads/software-project && echo ".env\ndatasets/" >> .gitignore
    ```
    {: .warning }
    By default, Git is not designed to support the tracking of large files, and is of limited utility if those files are binary or do not change often.
    
4. Check your code for secrets and move them to the `.env` file.  Refactor your code to incorporate the use of the [python-dotenv package](https://pypi.org/project/python-dotenv) to load the secrets, if required.

5. Add all of the software project's files to staging.  Staging is the intermediate step before committing file changes.
   ```
   cd ~/Downloads/software-project && git add .
   ```

6. Commit the most recent changes, providing a descriptive message to describe the change.  As we are committing all files for the first time, we will just describe this change as "Initial Commit".
   ```
   cd ~/Downloads/software-project && git commit -m "Initial Commit"
   ```

## Working with Git

With the project initialized, you may begin development work the software project, staging changes and committing with descriptive comments.  You can combine staging and committing in one step.
   ```
   git commit -am "Combined Staging and Commit of successful debug"
   ```

Commits are typically made to branches.  The default branch is named **main**.  The current branch is displayed when checking the status of staged files and commits.
    ```
    git status
    ```
New branches are often used to develop features, test significant changes, enable work assignments, or contain other phases of development.

## Push to GitHub

1. Set up key.
    ```
    [ -z "$(git config --global user.email)" ] && echo "Error: user.email is not set in Git configuration." >&2 && exit 1 || ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f ~/.ssh/github-local -N ""
    ```

2. Copy key to GitHub.

3. Test key.

4. Add remote.
    ```
    git remote add origin git@github.com:sally/ride-project.git
    ```
4. Load key for use.
5. Push local to remote.
    ```
    git push -u origin main
    ```

## Pull from GitHub

1. Set up key.
    ```
    [ -z "$(git config --global user.email)" ] && echo "Error: user.email is not set in Git configuration." >&2 && exit 1 || ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f ~/.ssh/github-hpc -N ""
    ```
2. Test key.
3. Load key for use.
4. Pull remote to local.