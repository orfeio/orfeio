---
title: Rsafd
layout: default 
---

# Rsafd

Rsafd is an R package that provides statistical analysis of financial data.

## Rsafd and Jupyter Notebook

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
4. Initialize Miniconda, then close and re-open the Terminal app.
    ```
    ~/miniconda3/bin/conda init bash ; ~/miniconda3/bin/conda init zsh
    ```
5. Configure the conda command to prioritize the Apple channel first, the Conda Forge channel second.
    ```
    conda config --add channels conda-forge --add channels apple
    ```
6. Create a conda environment named Renv.
    ```
    conda create -y -n Renv tensorflow keras jupyter r-irkernel
    ```
7. Activate the Renv environment.
    ```
    conda activate Renv
    ```
8. Correct for a bug in the environment installation.
    ```
    [ -f $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.3.0 ] && ln -s $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.3.0 $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.0.1
    ```
9. Install the necessary R packages.
    ```
    PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P" Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com')"
    ```
    
10. Download the Rsafd R package.
    ```
    curl -L https://carmona.princeton.edu/orf505/Rsafd.zip -o ~/Downloads/Rsafd.zip
    ```
11. Decompress the Rsafd R package.
    ```
    unzip -o ~/Downloads/Rsafd.zip -d ~/Downloads
    ```
12. Install the Rsafd R package.
    ```
    Rscript -e "install.packages('~/Downloads/Rsafd', repos = NULL, type='source')"
    ```
13. Close Terminal.

Each time you wish to work with a Jupyter Notebook for the class, open the Terminal app and then run the following commands.

1. Activate the Renv conda environment.
    ```
    conda activate Renv
    ```
2. Open Jupyter.
   ``` 
   jupyter notebook
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
8. Create a conda environment named `Renv`.
    ```
    conda create -y -n Renv unzip jupyter==1.0.0 tensorflow==2.12.1 r-irkernel==1.3.2 keras==2.12.0
    ```
9. Activate the Renv environment.
    ```
    conda activate Renv
    ```
10. Install the necessary R packages.
    ```
    Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl'), repos='https://cran.rstudio.com')"
    ```
11. Download and extract the Rsafd R package.
    ```
    curl -L https://carmona.princeton.edu/orf505/Rsafd.zip -o Rsafd.zip ; unzip -o ~/Rsafd.zip -d ~
    ```
12. Install the Rsafd R package.
    ```
    Rscript -e "install.packages('~/Rsafd', repos = NULL, type='source')"
    ```
13. Close the Ubuntu app.

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
