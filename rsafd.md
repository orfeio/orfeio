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

## All Platforms via Docker 

Use [a pre-built Docker image](https://github.com/princetonuniversity/rsafd-docker) that includes Python, R, [Rsafd](https://github.com/princetonuniversity/rsafd), dependencies, and Jupyter.

 Requires an installation of [Docker Desktop](https://docs.docker.com/desktop/).

Open Docker Desktop and run the command appropriate for your platform in the Docker Desktop Terminal window.

macOS / Linux:
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 -v "$HOME":/workspace/notebooks ghcr.io/princetonuniversity/rsafd-docker:latest
```
Windows (PowerShell):
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 -v "${env:USERPROFILE}:/workspace/notebooks" ghcr.io/princetonuniversity/rsafd-docker:latest
```
Open the printed URL in your browser to begin working with notebooks; see [the README](https://github.com/princetonuniversity/rsafd-docker#rsafd-docker) for further details.

Follow the manual, conda-based instructions if you prefer a local (non-container) installation or wish to customize at a lower level.

## Manual Installation

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
    {: .warning }
    This step requires conda to resolve a complex set of dependencies such that each requested software component can install.  This short list should take tens of minutes, not hours.  If you're having trouble, try the [Alternative Environment Creation Method](#alternative-environment-creation-method) and then return to complete the remaining steps.
    
8. Activate the Renv environment.
    ```
    conda activate Renv
    ```
9. Correct for a bug in the environment installation.
    ```
    [ -f $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.3.0 ] && ln -s $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.3.0 $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.0.1
    ```
10. Install the necessary R packages.
    ```
    PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P" Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com')"
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

Paste each of the following commands into a new cell of a Google Colab notebook that is set to use the R runtime.

The runtime is set under the Runtime menu by clicking on Change Runtime Type.

1. Install the necessary R packages.
    ```
    install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com')
    ```
2. Download the Rsafd package.
   ``` 
   rsafd_url <- 'https://carmona.princeton.edu/orf505/Rsafd.zip'
   download.file(rsafd_url, destfile = 'Rsafd.zip')
   ```
3. Decompress the Rsafd package.
   ``` 
   unzip('Rsafd.zip')
   ```
4. Install the Rsafd package.
   ```
   install.packages('Rsafd', repos = NULL, type = 'source')
   ```

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
   {: .warning }
   This step requires conda to resolve a complex set of dependencies such that each requested software component can install.  This short list should take tens of minutes, not hours.  If you're having trouble, try the [Alternative Environment Creation Method](#alternative-environment-creation-method) and then return to complete the remaining steps.
   
7. Activate the Renv environment.
    ```
    conda activate Renv
    ```
8. Install the necessary R packages.
    ```
    Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl'), repos='https://cran.rstudio.com')"
    ```
9. Download and extract the Rsafd R package.
    ```
    curl -L https://carmona.princeton.edu/orf505/Rsafd.zip -o Rsafd.zip ; unzip -o ~/Rsafd.zip -d ~
    ```
10. Install the Rsafd R package.
    ```
    Rscript -e "install.packages('~/Rsafd', repos = NULL, type='source')"
    ```
11. Close the Ubuntu app.

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

## Alternative Environment Creation Method

If the creation of the environment is taking 30 minutes or more on your computer or is otherwise incomplete, download the file corresponding to your architecture, then use the command `conda create --name Renv --file <file_name>` to create the environment, substituting the file's name and location for `<file_name>`.

* [Mac (Apple Silicon)](renv-spec-macm.txt), [Mac (Intel)](renv-maci.txt)
* [Windows (Intel)](renv-spec-win.txt)

This method skips dependency resolution by providing conda a predefined list of software versions.
