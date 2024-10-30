---
title: Rstudio Sessions
layout: default
---

# Rstudio Sessions and Environment Management

Research Computing hosts [robust documentation and guidance](https://researchcomputing.princeton.edu/support/knowledge-base/rrstudio) on using both R and RStudio on HPC research clusters.

This supplement assumes Initial Setup is complete according to the [Use Conda on Any PU HPC System](https://orfe.io/condarc.html) guide.  See the guide for additional environment management steps, such as removal.

## Create a New R Environment

Perform these steps interactively in a shell on one of the cluster head nodes. 

1. Use the conda command to create a new environment.  For this example, we will name the environment `renv`, indicate we want to install R, and use [the conda-forge channel](https://conda-forge.org/docs/user/introduction/) as the source.
    
    ```
    conda create -n renv r-base -c conda-forge -y
    ```
    
2. Activate the environment you just created.  If you've done so successfully, the active environment name will be displayed before your prompt.
    ```
    conda activate renv
    ```

3. Use the `conda` command to install additional R packages, if possible.  Most, but not all, R packages are available via `conda`.  The package name is always prefixed by `r-` and in lowercase.

    ```
    conda install r-igraph -c conda-forge -y
    ```
    
4. If a package is unavailable via or unknown to `conda`, type `R` to enter an R prompt and use the `install packages()` function.  Exit the R prompt with `q()`.

    ``` 
    > install.packages('gravity')
    ```

    {: .note }
    This installation method often requires the compilation of dependent libraries, making it a lengthy and error-prone process.  Whenever possible, try to install the package via `conda` before pursuing this method.
 
## Rstudio Session and the Environment

RStudio sessions on the clusters are interactive, scheduled under Interactive Apps with RStudio listed as "RStudio Server".

When requesting an RStudio session, add the location of your environment's `R` command to the Add to Path field.

Retrieve this location by opening a Terminal, activating the environment, and typing `which R`.  Copy and paste the resulting value to the Add to Path field, removing the trailing R.
