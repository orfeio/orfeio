---
title: Git & GitHub
layout: default
---

# Git & GitHub

[Git](https://git-scm.com) is a version control system for tracking changes in your projects.

[GitHub](https://github.com) is a web-based hosting service for Git-managed projects, enabling collaboration on both public and private repositories.

This guide walks you through setting up Git, creating and managing a project, and collaborating with others privately using GitHub.

## Prerequisites

This guide assumes you have:
- A device running macOS, WSL, or Linux.
- A software project stored in a folder locally on the device.
- An account on [GitHub](https://github.com).
- A new, empty, private repository in your personal GitHub account.
- Access to [an HPC environment](/condarc.html).

Paste each of the following commands into the Terminal app on your device.  

{ .note }
The example prefix cd ~/Downloads/software-project for example commands may be omitted if the Terminal is already open to your software project's folder.  You can check by examining the output of the command pwd.

{: .warning }
By default, Git is not designed to support the tracking of large files, and is of limited utility if those files are binary or do not change often.

## Local Git

From a Terminal, set Git's defaults, initialize Git's tracking of the software project, and start committing changes.

1. Configure Git with your name and email.  This information will be available to anyone with access to the project.
    ```
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    ```
2. Initialize Git's tracking of the project from within the project's folder.  For this example, we will assume the project is in the Downloads folder and named `software-project`.
    ```
    cd ~/Downloads/software-project && git init
    ```
3. Create a `.gitignore` file in the `software-project` folder to exclude large datasets and secrets from tracking.  We will assume datasets are saved in the folder named `datasets` and secrets in a file named `.env`.
    ```
    cd ~/Downloads/software-project && printf ".DS_Store\n.env\ndatasets/" >> .gitignore
    ```
    { .note }
    On many systems, files that begin their name with a "." are hidden by default.  You may need to show hidden files if you wish to make edits or changes manually to the `.gitignore` file.  For instance, Command+Shift+. on macOS will temporarily show all hidden files.
    
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

With the project initialized, begin development work, staging changes and committing with descriptive comments.  You can combine staging and committing in one step.
   ```
   git commit -am "Combined Staging and Commit of successful debug"
   ```

Commits are typically made to branches.  The default branch is named **main**.  The current branch is displayed when checking the status of staged files and commits.
    ```
    git status
    ```
New branches are often used to develop features, test significant changes, enable work assignments, or contain other phases of development.

## Push to GitHub

A trust relationship enables pushing local changes to a remote repository.  The relationship is established through an exchange of SSH keys between the local device and GitHub.

Follow these steps on your local device.

### Add Local Public Key to GiHub

1. Create a private and public key pair.
    ```
    [ -z "$(git config --global user.email)" ] && echo "Error: user.email is not set in Git configuration." >&2 && exit 1 || ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f ~/.ssh/github-local -N ""
    ```
    {: .warning }
    The private key should never be shared, only the public key.

2. Display the public key. Copy and paste it into the Key field of [a new SSH Key entry](https://github.com/settings/ssh/new) associated with your GitHub account.
    ```
    cat ~/.ssh/github-local.pub
    ```

3. Load the key for use and test the trust relationship.
    ```
    ssh-add ~/.ssh/github-local
    ssh -T git@github.com
    ```

### Push Local to Remote

An established trust relationship enables pushing (sending) or pulling (receiving) changes from a remote repository paired with a local one.

{: .note }
Git uses the term "upstream" to mean any remote repository that may be used for pushing, fetching, or pulling changes to and from.

1. Add a remote repository named `origin` to your local repository.
    ```
    git remote add origin git@github.com:<your_username>/software-project.git
    ```

2. Set upstream for the main branch to the remote named `origin`.
   ```
   git branch --set-upstream-to=origin/main main
   ```

5. Push local changes to the remote.
    ```
    git push -u origin main
    ```

## Pull from GitHub

If changes are pushed to GitHub from a local repository, pulling those changes onto an HPC environment completes a software development workflow.

Again, an established trust relationship between local and remote enables pulling changes to the environment, and in this case, is an exchange of keys between the HPC environment and GitHub.

Follow these steps from within the HPC environment.

### Add HPC Public Key to GitHub

1. Create a private and public key pair.
    ```
    [ -z "$(git config --global user.email)" ] && echo "Error: user.email is not set in Git configuration." >&2 && exit 1 || ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f ~/.ssh/github-hpc -N ""
    ```
    {: .warning }
    The private key should never be shared, only the public key.

2. Display the public key. Copy and paste it into the Key field of [a new SSH Key entry](https://github.com/settings/ssh/new) associated with your GitHub account.
    ```
    cat ~/.ssh/github-hpc.pub
    ```

3. Load the key for use and test the trust relationship.
    ```
    ssh-add ~/.ssh/github-hpc
    ssh -T git@github.com
    ```

### Pull Remote to HPC

{: .note }
You may need to re-run `ssh-add ~/.ssh/github-hpc` if you've disconnected from the HPC environment and the key is not set to automatically load.

1.  Clone the repository to the HPC environment.
    ```
    git clone git@github.com:<your_username>/software-project.git
    ```

2. Pull changes from GitHub.
   ```
   cd software-project && git pull
   ```