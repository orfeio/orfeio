---
title: Kdb+ Queries via R
layout: default 
nav_order: 2
---

# Kdb+ Queries via R

[Kdb+](https://kx.com) is a commercial database used in high-frequency trading.  The database is accessed via the proprietary programming language [Q](https://code.kx.com/home/).

When working with data in R, queries written in Q can be passed to the database, with the results stored as R objects.  This requires the use of the R package [rkdb](https://github.com/KxSystems/rkdb).

For software projects, it is good practice to use a tool to manage packages and dependencies. For the purpose of this example, we will use the conda command, which ships with installations of both [Anaconda](https://www.anaconda.com/products/distribution) and [Miniconda](https://docs.conda.io/en/latest/miniconda.html).[^minic]

We will use the tool to build an environment that includes all the dependencies necessary to send queries in Q via R, all while working in a Jupyter notebook.

## Setup

### macOS

1. Make sure your OS is [completely up-to-date](https://support.apple.com/en-us/HT201541), then install the Apple Developer Command Line Tools are installed by running the following command in the Terminal app.
    ```
    xcode-select --install
    ```

2. Create a conda environment that includes [Jupyter](https://jupyter.org) and [R](https://www.r-project.org), as well as the R package `devtools`.  For this example, we will name our environment `kdbrtest`, but you may name it anything you wish.
    ```
    conda create -y --name kdbrtest jupyter r-irkernel r-devtools
    ```

3. Install the `rkdb` package.  For installation, we use R and the `devtools` package to download and compile the code hosted in the `rkdb` repository.
    ```
    Rscript -e "devtools::install_github('kxsystems/rkdb')"
    ```

Now, each time you want to work with R and the `rkdb` package, activate the `kdbrtest` environment via the Terminal app with the command `conda activate kdbrtest` and then type `jupyter notebook`.

### Windows

1. Open the Anaconda Prompt app and create a conda environment that includes [Jupyter](https://jupyter.org) and [R](https://www.r-project.org), as well as the R package `devtools`.  For this example, we will name our environment `kdbrtest`, but you may name it anything you wish.
    ```
    conda create -y --name kdbrtest jupyter r-irkernel r-devtools r-installr
    ```

2. Open Jupyter to further prepare the environment.
    ```
    jupyter notebook
    ```

3. Use the R package `installr` to help install [RTools](https://cran.r-project.org/bin/windows/Rtools/), which allows for building packages like `rkdb` from source.  You'll be prompted to complete the installation graphically after running these commands in a cell inside a new notebook.[^rtools]
	```
    library(installr)
	install.Rtools(check=FALSE,check_r_update=FALSE,GUI=FALSE)
    ```

4. Complete the installation of `rkdb` by calling devtools from another cell after the Rtools installation is complete.
    ```
    devtools::install_github('kxsystems/rkdb')
    ```
Now, each time you want to work with R and the `rkdb` package, activate the `kdbrtest` environment via the Anaconda Prompt app with the command `conda activate kdbrtest` and then type `jupyter notebook`.

[^minic]: If you haven't installed Anaconda yet, go with Miniconda instead.
[^tools]: Accept all the graphical defaults unless you know you have an existing Rtools installation.