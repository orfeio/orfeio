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
    ln -s $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.3.0 $CONDA_PREFIX/lib/gcc/arm64-apple-darwin20.0.0/11.0.1
    ```
9. Install the necessary R packages.
    ```
    PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P" Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl', 'glmnet'), repos='https://cran.rstudio.com')"
    ```
    
10. Download the Rsafd R package.
    ```
    curl https://carmona.princeton.edu/orf505/Rsafd.zip -o ~/Downloads/Rsafd.zip
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

1. [Download and install Miniconda](https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe).
2. Open the Anaconda Prompt (Miniconda3) by finding it within the Windows (logo) Menu or by searching for it by name.
3. Configure the conda command to prioritize the Conda Forge channel first, then the default.
    ```
    conda config --add channels conda-forge
    ```
4. Create a conda environment named Renv.
    ```
    conda create -y -n Renv tensorflow keras jupyter r-irkernel r-igraph curl
    ```
5. Activate the Renv environment.
    ```
    conda activate Renv
    ```
6. Install the necessary R packages.
    ```
    Rscript -e "install.packages(c('timeDate', 'quadprog', 'quantreg', 'plot3D', 'robustbase', 'scatterplot3d', 'splines', 'tseries', 'glasso', 'qgraph', 'reticulate', 'keras', 'rgl'), repos='https://cran.rstudio.com')"
    ```
7. Download the Rsafd R package.
    ```
    curl https://carmona.princeton.edu/orf505/Rsafd.zip -o Rsafd.zip
    ```
8. Install the Rsafd R package.
    ```
    Rscript -e "install.packages('Rsafd.zip', repos = NULL)"
    ```
9. Close the Anaconda Prompt.

Each time you wish to work with a Jupyter Notebook for the class, open the Anaconda Prompt (Miniconda3) app and then run the following commands.

1. Activate the Renv conda environment.
    ```
    conda activate Renv
    ```
2. Open Jupyter.
    ```
    jupyter notebook
    ```
