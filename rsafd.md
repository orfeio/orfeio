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

### Google Colab

{: .note }
Multiple steps require switching the runtime between Python and R; switch the runtime for a step from the Change Runtime Type option on the Runtime menu. 

1. Switch to a Python runtime, then execute the following code to connect your Google Drive.
    ```
    from google.colab import drive
    drive.mount('/content/drive')
    ```
2. Switch to an R runtime, then execute the following code to install the Rsafd dependencies.
    ```
    drive_lib <- "/content/drive/MyDrive/Rlibs"
    dir.create(drive_lib, showWarnings = FALSE, recursive = TRUE)
    .libPaths(c(drive_lib, .libPaths()))
    install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com', lib = drive_lib)
    ```
3. [Download the Rsafd R package](https://github.com/PrincetonUniversity/Rsafd/releases/download/v20250902002429/Rsafd.zip), decompress, and install by copying the Rsafd folder to the Rlibs folder in your [Google Drive](https://drive.google.com/).

Each time you wish to work with a Colab Notebook, run the following commands.

1. Switch to a Python runtime and reconnect your Google Drive.
    ```
    from google.colab import drive
    drive.mount('/content/drive')
    ```
2. Switch to an R runtime and load the library.
    ```
    drive_lib <- "/content/drive/MyDrive/Rlibs"
    dir.create(drive_lib, showWarnings = FALSE, recursive = TRUE)
    .libPaths(c(drive_lib, .libPaths()))
    ```

## Local Install 

Local installation utilizes a [conda environment](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html). 

### macOS

All commands are executed from Terminal.

1. Install the Apple Developer Command Line Tools.
    ```
    xcode-select --install
    ```
2. [Download the R environment file](renv-spec-macm.txt) and use it to create the `Renv` environment.
    ```
    conda env create -f renv-spec-macm.txt
    ```
3. Activate the environment and install the necessary R packages.
    ```
    conda activate Renv
    Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com')"
    ```
4. Download, decompress, and install the Rsafd R package.
    ```
    curl -sL $(curl -sL https://api.github.com/repos/PrincetonUniversity/Rsafd/releases/latest | jq -r '.assets[] | select(.name == "Rsafd.zip") | .browser_download_url') -o ~/Downloads/Rsafd.zip
    unzip -o ~/Downloads/Rsafd.zip -d ~/Downloads/Rsafd
    cp -r ~/Downloads/Rsafd ${CONDA_PREFIX}/lib/R/library
    ```
5. Close Terminal.

Each time you wish to work with a Jupyter Notebook, open the Terminal app and then run the following commands.

1. Activate the Renv conda environment.
    ```
    conda activate Renv
    ```
2. Open Jupyter.
   ``` 
   jupyter notebook
   ```

### Windows

All commands require the Windows Subsystem for Linux (WSL) and the Ubuntu Linux app. The steps that follow assume WSL is not already installed and the WSL installation does not contain a conda installation. 

#### Prepare WSL 

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
6. Activate the Renv environment.
    ```
    conda activate Renv
    ```
7. Install the necessary R packages.
    ```
    Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl'), repos='https://cran.rstudio.com')"
    ```
8. Download and extract the Rsafd R package.
    ```
    curl -sL $(curl -sL https://api.github.com/repos/PrincetonUniversity/Rsafd/releases/latest | jq -r '.assets[] | select(.name == "Rsafd.zip") | .browser_download_url') -o ~/Downloads/Rsafd.zip ; unzip -o ~/Rsafd.zip -d ~/Rsafd
    ```
9. Install the Rsafd R package.
    ```
    cp -r ~/Rsafd ${CONDA_PREFIX}/lib/R/library
    ```
10. Close the Ubuntu app.

Each time you wish to work with a Jupyter Notebook, open the Ubuntu app and then run the following commands.

1. Activate the Renv conda environment.
    ```
    conda activate Renv
    ```
2. Start Jupyter.
    ```
    jupyter notebook
    ```
 
Note that for files and folders to be accessible to Jupyter, you will need to copy them to the Linux disk that appears along the left side of the File Explorer window.

## Docker Container

If you have an installation of [Docker Desktop](https://docs.docker.com/desktop/), [a pre-built Docker image](https://github.com/princetonuniversity/rsafd-docker) is available that includes Python, R, [Rsafd](https://github.com/princetonuniversity/rsafd), dependencies, and Jupyter.

Open Docker Desktop and run the command appropriate for your platform in the Docker Desktop Terminal window.

{: .warning }
If you receive a "Dead Kernel" message when attempting to load large datasets, you may need to adjust Docker Desktop's memory allocation.  See the [Troubleshooting section](https://github.com/princetonuniversity/rsafd-docker#troubleshooting) for more details. 

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
