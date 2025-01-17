---
title: Git & GitHub
layout: default
---

# Git & GitHub

[Git](https://git-scm.com) is a version control system for tracking changes in your projects.

[GitHub](https://github.com) is a web-based hosting service for Git-managed projects, enabling collaboration on both public and private repositories.

This guide outlines setting up Git on a local device, sending changes to a private GitHub repository, and pulling changes from GitHub to an HPC environment.

{: .note }
For the purpose of initial setup, this guide also assumes most development work will be done locally, sent to GitHub, and pulled onto the HPC environment.  Once initial setup is complete, the distributed nature of Git allows for reordering this workflow.  Samples are provided in the [Usage section](#usage).

## Prerequisites

- A device running macOS, Linux, or Windows with WSL installed.
- A software project stored in a folder locally on the device.
- An account on [GitHub](https://github.com).
- A new, empty, private repository in your personal GitHub account.
- Access to [an HPC environment](/condarc.html).

Paste each of the following commands into the Terminal app on your device.  

{: .warning }
By default, Git is not designed to support the tracking of large files, and is of limited utility if those files are binary or do not change often.  Synchronize large files and datasets by other means, such as [rsync or Globus](https://researchcomputing.princeton.edu/education/external-online-resources/data-transfer), or research and understand enabling [Git Large File Support](https://git-lfs.com).

## Initial Setup

### Local Git

From a Terminal, set Git's defaults, initialize Git's tracking of the software project, and start committing changes.  Perform each step by pasting the sample commands into the Terminal.

Unless otherwise noted, the steps assume your Terminal is open to the folder or directory of your software project.  Use the command `cd software-project`, substituting the path to your project folder.

{: .warning }
Examine the output of the `pwd` command to confirm you are working in the correct location.

1. Configure Git within the local environment with your name and email.  This information will be available to anyone with access to the project.
    ```
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    ```
2. Initialize Git's tracking of the project from within the project's folder.
    ```
    git init
    ```
3. Create a `.gitignore` file to exclude large datasets and secrets from tracking.  We will assume datasets are saved in the folder named `datasets` and secrets in a file named `.env`.
    ```
    printf ".DS_Store\n.env\ndatasets/" >> .gitignore
    ```
    {: .note }
    On many systems, files that begin their name with a "." are hidden by default.  You may need to show hidden files if you wish to make edits or changes manually to the `.gitignore` file.  For instance, the keyboard combination _Command + Shift + ._ on macOS will temporarily show all hidden files.
    
4. Check your code for secrets and move them to the `.env` file.  Refactor your code to incorporate the use of the [python-dotenv package](https://pypi.org/project/python-dotenv) to load the secrets, if required.

5. Add all of the software project's files to staging.  Staging is the intermediate step before committing file changes.
   ```
   git add .
   ```

6. Commit the most recent changes, providing a descriptive message to describe the change.  As we are committing all files for the first time, we will just describe this change as "Initial Commit".
   ```
   git commit -m "Initial Commit"
   ```

### Establish a Trust Relationship between Local Git & GitHub

A trust relationship, established via SSH Keys, enables pushing local changes via Git to the remote repository on GitHub.

#### Add SSH Public Key to GiHub

1. Create a private and public key pair on your local device.
    ```
    [ -z "$(git config --global user.email)" ] && echo "Error: user.email is not set in Git configuration." >&2 && exit 1 || ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f ~/.ssh/github-local -N ""
    ```
    {: .warning }
    Never share a private SSH key.

2. Display the public key. Copy and paste the contents of the public key into the Key field of [a new SSH Key entry](https://github.com/settings/ssh/new) associated with your GitHub account.
    ```
    cat ~/.ssh/github-local.pub
    ```

3. Load the key for use and test the trust relationship.
    ```
    ssh-add ~/.ssh/github-local
    ssh -T git@github.com
    ```

#### Add GitHub as a Remote

A remote is a reference to a version of a repository stored elsewhere.  Adding GitHub as a remote allows us to send our local changes.

{: .note }
Git uses the term "upstream" to mean any remote repository that may be used for pushing, fetching, or pulling changes to and from.

1. Add a remote repository named `origin` to your local repository.
    ```
    git remote add origin git@github.com:<your_username>/software-project.git
    ```

2. Push local changes to the remote.
    ```
    git push -u origin main
    ```

### HPC Git

Open an Terminal within your HPC environment and configure Git within the HPC environment with your name and email.
```
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

#### Establish a Trust Relationship between HPC and GitHub

A trust relationship, established via SSH Keys, also enables pulling changes via Git to the HPC environment from a remote repository on GitHub.

1. Create a private and public key pair for HPC use.
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

#### Clone from GitHub

1. Clone the repository to the HPC environment.
    ```
    git clone git@github.com:<your_username>/software-project.git
    ```

2. Change to the project directory or folder.
   ```
   cd software-project
   ```

2. Pull and accept changes from GitHub.
   ```
   git pull
   ```

## Usage

With [Initial Setup](#initial-setup) complete, you may stage files, commit changes, and push (send) or pull (receive) changes on either your local device or the HPC environment, with the hosted GitHub repository acting as intermediary.

{: .note }
You may need to run `ssh-add ~/.ssh/github-*` before pushing or pulling any changes if your local device has restarted or you've disconnected from the HPC environment in order to reload the SSH key.

| Git Command                    | Purpose                                                              |
| ------------------------------ | -------------------------------------------------------------------- |
| git status                     | Check the status of staged files and pending commits.                |
| git add .                      | Stage all new and modified files, except those in .gitignore.        |
| git commit -m "Commit Message" | Commit the changes to staged files, adding your own "Commit Message" |
| git push                       | Send committed changes to a remote.                                  |
| git pull                       | Receive committed changes from a remote.                             |
[Common Git Commands]