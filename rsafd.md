---
title: Rsafd
layout: default 
---

# Rsafd

Rsafd is an R package that provides statistical analysis of financial data.
## Contents
{: .no_toc }

* TOC
{:toc}

## Semi-Automated macOS Install

If you already have a conda installation, [download this environment file](renv-spec-macm.txt).

Use the command `conda create --name Renv --file <file_name>` to create the `Renv` conda environment, substituting the file's name and location for `<file_name>`.

<!-- * [Mac (Apple Silicon)](renv-spec-macm.txt) -->
<!-- * [Mac (Intel)](renv-maci.txt) -->
<!-- * [Windows (Intel)](renv-spec-win.txt) -->

{: .note }
This method assumes a device with Apple Silicon (M1 processor or later, introduced Nov 2020).  For older Intel-based devices, please use the manual installation steps or an alternative.

Once done, continue with [step 8 for macOS](#step8mac) <!-- or [step 6 for Windows](#step6win) --> of the Manual Install steps to complete the installation.

## Docker Container

If you have an installation of [Docker Desktop](https://docs.docker.com/desktop/), [a pre-built Docker image](https://github.com/princetonuniversity/rsafd-docker) is available that includes Python, R, [Rsafd](https://github.com/princetonuniversity/rsafd), dependencies, and Jupyter.

Open Docker Desktop and run the command appropriate for your platform in the Docker Desktop Terminal window.

### macOS 
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 -v "$HOME":/workspace/notebooks ghcr.io/princetonuniversity/rsafd-docker:latest
```
### Windows (PowerShell)
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 -v "${env:USERPROFILE}:/workspace/notebooks" ghcr.io/princetonuniversity/rsafd-docker:latest
```

### Linux
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 --user $(id -u):$(id -g) -v "$HOME":/workspace/notebooks -e HOME=/workspace/notebooks --workdir /workspace/notebooks ghcr.io/princetonuniversity/rsafd-docker:latest
```

Open the printed URL in your browser to begin working with notebooks; see [the README](https://github.com/princetonuniversity/rsafd-docker#rsafd-docker) for further details.

## Manual Install 

The manual installation is native to your operating system and based on a [conda environment](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).

### macOS

Paste each of the following commands into the Terminal app.  You can find the Terminal app inside the Utilities folder found within the Applications folder, or search for "Terminal".

1. Install the Apple Developer Command Line Tools.
    ```
    xcode-select --install
    ```
2. Download Miniconda.
    ```
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-`uname -m`.sh -o ~/Downloads/miniconda.sh
    ```
3. Install Miniconda.
    ```
    chmod +x ~/Downloads/miniconda.sh ; ~/Downloads/miniconda.sh -bu
    ```
4. Initialize Miniconda.
    ```
    ~/miniconda3/bin/conda init bash ; ~/miniconda3/bin/conda init zsh
    ```
5. Close and re-open the Terminal.
6. Configure the conda command to prioritize the Apple channel first, the Conda Forge channel second.
    ```
    conda config --add channels conda-forge --add channels apple
    ```
7. Create a conda environment named Renv.
    ```
    conda create -y -n Renv tensorflow keras jupyter r-irkernel r-hmisc
    ```
8. <a name="step8mac"></a>Activate the Renv environment.
    ```
    conda activate Renv
    ```
10. Install the necessary R packages.
    ```
    Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com')"
    ```
11. Download the Rsafd R package.
    ```
    curl -L https://carmona.princeton.edu/orf505/Rsafd.zip -o ~/Downloads/Rsafd.zip
    ```
12. Decompress the Rsafd R package.
    ```
    unzip -o ~/Downloads/Rsafd.zip -d ~/Downloads
    ```
13. Install the Rsafd R package.
    ```
    Rscript -e "install.packages('~/Downloads/Rsafd', repos = NULL, type='source')"
    ```
14. Close Terminal.

Each time you wish to work with a Jupyter Notebook for the class, open the Terminal app and then run the following commands.

1. Activate the Renv conda environment.
    ```
    conda activate Renv
    ```

    {: .warning }
    If you have a previously-installed version of Anaconda, you may need to use the following to activate the environment.

   `conda activate $HOME/miniconda3/envs/Renv`

2. Open Jupyter.
   ``` 
   jupyter notebook
   ```

### Google Colab

Each time you work with Google Colab (including the first time you install Rsafd) connect your Google Drive with this code from a Python runtime cell (change runtime using the icon in the lower-right corner).
```
from google.colab import drive
drive.mount('/content/drive')
```

Switch to an R runtime, and prepare the R environment, executing this code.
```
drive_lib <- "/content/drive/MyDrive/Rlibs"
dir.create(drive_lib, showWarnings = FALSE, recursive = TRUE)
.libPaths(c(drive_lib, .libPaths()))
``` 

To install Rsafd the first time, run the following command in an R runtime cell to install the Rsafd dependencies.
```
install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com', lib = drive_lib)
```

Download the [Rsafd.zip](https://carmona.princeton.edu/orf505/Rsafd.zip) file, extract the Rsafd folder, and upload the Rsafd folder to the Rlibs folder in your [Google Drive](https://drive.google.com/).

### Windows

We will use the Windows Subsystem for Linux and the Ubuntu Linux app as the foundation of our development environment.  This will have the additional benefit of our environment working like other Linux systems, from cloud-provided servers to high performance computing environments.

#### Prepare the Linux Subsystem

1. Search for and open the "Turn Windows Features On and Off" control panel on your computer.
2. Check the box labeled "Virtual Machine Platform", click the Ok button and then restart.
3. [Install Windows Subsystem for Linux (WSL)](https://www.microsoft.com/store/productid/9P9TQF7MRM4R) via the Microsoft Store.
4. [Install Ubuntu](https://www.microsoft.com/store/productid/9PDXGNCFSCZV) via the Microsoft Store.
5. Open the Ubuntu app to complete the Linux installation process.  Provide a username and password when prompted.  These can optionally match those you already use to log in to your computer.

#### Install and Configure the Development Environment

Each of the remaining commands can be pasted into the Ubuntu app window.

1. Download Miniconda.
    ```
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-`uname -m`.sh -o ~/miniconda.sh
    ```
2. Install Miniconda.
    ```
    chmod +x ~/miniconda.sh ; ~/miniconda.sh -bu
    ```
3. Initialize Miniconda, then close and re-open the Ubuntu app.
   ```
   ~/miniconda3/bin/conda init bash ; ~/miniconda3/bin/conda init zsh
   ```
4. Configure the conda command to prioritize the Conda Forge channel first, then the default.
    ```
    conda config --add channels conda-forge
    ```
5. Create a conda environment named `Renv`.
    ```
    conda create -y -n Renv unzip jupyter==1.0.0 tensorflow==2.12.1 r-irkernel==1.3.2 keras==2.12.0 r-hmisc
    ```
6. <a name="step6win"></a>Activate the Renv environment.
    ```
    conda activate Renv
    ```
7. Install the necessary R packages.
    ```
    Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl'), repos='https://cran.rstudio.com')"
    ```
8. Download and extract the Rsafd R package.
    ```
    curl -L https://carmona.princeton.edu/orf505/Rsafd.zip -o Rsafd.zip ; unzip -o ~/Rsafd.zip -d ~
    ```
9. Install the Rsafd R package.
    ```
    Rscript -e "install.packages('~/Rsafd', repos = NULL, type='source')"
    ```
10. Close the Ubuntu app.

Each time you wish to work with a Jupyter Notebook for the class, open the Ubuntu app and then run the following commands.

1. Activate the Renv conda environment.
    ```
    conda activate Renv
    ```
2. Start Jupyter.
    ```
    jupyter notebook
    ```
3. Visit the [Jupyter web interface](http://localhost:8888/tree).
   
Note that for files and folders to be accessible to Jupyter, you will need to copy them to the Linux disk that appears along the left side of the File Explorer window.

