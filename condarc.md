---
title: Conda on HPC
layout: default
nav_order: 5
---

# Use Conda on Any PU HPC System

## Initial Setup

The initial setup need only be run once to begin using Conda environments on a PU HPC system.

You may also repeat these steps if you'd like to start over as if it is your first time using a Conda environment on a PU HPC system.

1. Open a Terminal on the remote system and use the `module` command to load Anaconda.  The `module` command activates one of many software installations available on a given system.
    
    ```
    module load anaconda3/2024.2
    ```

2. Remove any existing conda settings, environments, and related data from the Terminal.  With this example command, we move the `.condarc` file and the `.conda` folder to `condarc-backup` and `conda-backup` in `$HOME`.  Dispose of them to [free up quota](https://researchcomputing.princeton.edu/support/knowledge-base/checkquota) once you have a working environment.
    
    ```
    PU_TIMESTMP=(`date '+%b_%d_%Y_%H%M%S'`); [ -d $HOME/.conda ] && mv $HOME/.conda $HOME/conda-backup-$PU_TIMESTMP; [ -f $HOME/.condarc ] && mv $HOME/.condarc $HOME/condarc-backup-$PU_TIMESTMP
    ```
    
3. Configure `conda` to store both its package cache and environments in a location other than your `$HOME`.[^quota]  In addition, prioritize the `conda-forge` channel for software installations by default.  With this example command, we write the necessary configuration changes to a new `$HOME/.condarc` file.
    
    ```
    PU_HPC_SYS=(`echo $HOSTNAME | tr -d '0123456789'`); if [ $PU_HPC_SYS = 'adroit' ]; then SCRATCH_LOC='network' ; else SCRATCH_LOC='gpfs' ; fi; echo -e "pkgs_dirs:\n - /scratch/$SCRATCH_LOC/$USER/.conda/pkgs\nenvs_dirs:\n - /scratch/$SCRATCH_LOC/$USER/.conda/envs" > $HOME/.condarc ; conda config --add channels conda-forge ; mkdir -p $HOME/.conda /scratch/$SCRATCH_LOC/$USER/.conda/{pkgs,envs} ; touch $HOME/.conda/environments.txt ; ln -s /scratch/$SCRATCH_LOC/$USER/.conda/{pkgs,envs} $HOME/.conda
    ```

## Creating a New Environment

1. Use the conda command to create a new environment.  For this example, we will name the environment "torch-env", indicative of PyTorch development.  We'll install ipykernel inside for now in order to be able to [use the custom environment with Jupyter](https://researchcomputing.princeton.edu/support/knowledge-base/jupyter).
    
    ```
    conda create -n torch-env ipykernel -c conda-forge -y
    ```

    {: .note }
    While there are good references for getting started with [Pytorch on the HPC Clusters](https://researchcomputing.princeton.edu/support/knowledge-base/pytorch#install), the process can be problematic.  To both demonstrate the flexibility of the `conda` command and avoid some trouble, we will create the environment, activate the environment, and install additional packages via both `conda` and `pip` safely and reproducibly.
    
2. Activate the environment you just created.  If you've done so successfully, the active environment name will be displayed before your prompt.
    ```
    conda activate torch-env
    ```

3. Use the `conda` command to install PyTorch.  Note that the command recommended for the HPC environment is prefixed by manually setting a value for the `CONDA_OVERRIDE_CUDA` variable, and uses the constraint `pytorch==2.0*==cuda11*`.  This is to allow the installation to properly complete in the absence of a GPU on the head node, but still work in the presence of a GPU on the nodes themselves.

    ```
    CONDA_OVERRIDE_CUDA="11.2" conda install "pytorch==2.0*=cuda11*" torchvision -c conda-forge -y
    ```
    
4. Install other useful packages via pip.  When pip is managed by `conda`, as it is in our `torch-env` environment, `conda` is aware of any `pip`-installed packages.

    ``` 
    pip install scikit-learn
    pip install quantile_forest
    pip install matplotlib
    pip install seaborn
    ```

## Removing an Environment

The [Initial Setup](#initial-setup) can be used to re-initialize your entire `conda` configuration, but that may be too aggressive.  To remove an existing environment, for instance, `torch-env`, pass its name to the `conda` command:

    conda env remove --name torch-env

## Installing New Packages into Existing Environments

When working with environments via the Terminal, always load the Anaconda module, which then makes the `conda` command available.

    module load anaconda3/2024.2

Once the `conda` command is available, you can proceed to activate the environment by name.

    conda activate torch-env

Add new software to the active environment using either `conda` or `pip`.  When in doubt, favor `conda`, but don't discount `pip`.

    conda install pandas

[^quota]: Please note that data stored outside your `$HOME` is [not backed up](https://researchcomputing.princeton.edu/support/knowledge-base/checkquota#scratch).  This is typically inconsequential if you know how to reconstruct your environment and maintain your own backups of any other project data you may wish to store there.
