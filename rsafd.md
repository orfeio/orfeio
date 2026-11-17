---
title: Rsafd
layout: default
---

# Rsafd

[Rsafd](https://github.com/PrincetonUniversity/Rsafd) is the R package for *Statistical Analysis of Financial Data in R*. Choose one way to use it. The Miniconda and Docker setups are tested whenever the package changes.

## Contents
{: .no_toc }

* TOC
{:toc}

## Miniconda

Creates a conda environment named `Renv` with R, Python, Jupyter, TensorFlow and Keras, then installs Rsafd.

### macOS (Apple Silicon)

1. [Install Miniconda](https://www.anaconda.com/docs/getting-started/miniconda/install) if the `conda` command is not available in Terminal.
2. In Terminal, create the environment and install Rsafd.
    ```
    curl -fsSL https://raw.githubusercontent.com/PrincetonUniversity/Rsafd/main/conda/renv-osx-arm64.txt -o /tmp/renv.txt
    conda create -y -n Renv --override-channels -c conda-forge --file /tmp/renv.txt
    conda activate Renv
    Rscript -e 'install.packages("https://github.com/PrincetonUniversity/Rsafd/releases/latest/download/Rsafd.tar.gz", repos = NULL, type = "source")'
    ```

### Windows (WSL)

1. Set up WSL once:
    1. Open "Turn Windows features on or off", check **Virtual Machine Platform**, click OK, and restart.
    2. Install [WSL](https://www.microsoft.com/store/productid/9P9TQF7MRM4R) and [Ubuntu](https://www.microsoft.com/store/productid/9PDXGNCFSCZV) from the Microsoft Store.
    3. Open the Ubuntu app and choose a username and password.
2. In the Ubuntu app, install Miniconda, then close and reopen the app.
    ```
    curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -o ~/miniconda.sh
    bash ~/miniconda.sh -b -u && ~/miniconda3/bin/conda init bash
    ```
3. Create the environment and install Rsafd.
    ```
    curl -fsSL https://raw.githubusercontent.com/PrincetonUniversity/Rsafd/main/conda/renv-linux-$(uname -m).txt -o /tmp/renv.txt
    conda create -y -n Renv --override-channels -c conda-forge --file /tmp/renv.txt
    conda activate Renv
    Rscript -e 'install.packages("https://github.com/PrincetonUniversity/Rsafd/releases/latest/download/Rsafd.tar.gz", repos = NULL, type = "source")'
    ```

{: .note }
Jupyter in WSL sees only the Linux file system. Copy your files to the Linux drive shown in File Explorer's sidebar.

### Each session

```
conda activate Renv
jupyter notebook
```

Then run `library(Rsafd)` in an R notebook. To update Rsafd, repeat the `Rscript` command above. To remove everything, run `conda env remove -n Renv`.

## Docker

Includes Python, R, Rsafd and Jupyter. Requires [Docker Desktop](https://docs.docker.com/desktop/). Run the command for your platform in a terminal, then open the printed URL.

macOS
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 -v "$HOME":/workspace/notebooks ghcr.io/princetonuniversity/rsafd:latest
```

Windows (PowerShell)
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 -v "${env:USERPROFILE}:/workspace/notebooks" ghcr.io/princetonuniversity/rsafd:latest
```

Linux
```
docker run -p 8888:8888 -e JUPYTER_LINK_ONLY=1 --user $(id -u):$(id -g) -v "$HOME":/workspace/notebooks -e HOME=/workspace/notebooks --workdir /workspace/notebooks ghcr.io/princetonuniversity/rsafd:latest
```

{: .warning }
A "Dead Kernel" when loading large data sets means Docker needs more memory. See [Docker options and troubleshooting](https://github.com/PrincetonUniversity/Rsafd#docker-jupyter-with-r-and-python).

The image replaces `ghcr.io/princetonuniversity/rsafd-docker`, which is no longer updated.

## Google Colab

Install Rsafd once into your Google Drive, then load it from there in each session.

{: .note }
Switch between Python and R with Runtime > Change runtime type.

1. **Python runtime:** connect Google Drive.
    ```
    from google.colab import drive
    drive.mount('/content/drive')
    ```
2. **R runtime:** use a library folder in your Drive. Run this at the start of every session.
    ```
    lib <- "/content/drive/MyDrive/Rlibs"
    dir.create(lib, showWarnings = FALSE, recursive = TRUE)
    .libPaths(c(lib, .libPaths()))
    ```
3. **R runtime, first time only:** install Rsafd and its dependencies into that folder.
    ```
    install.packages(c("plot3D", "quantreg", "robustbase", "timeDate", "tseries"), lib = lib)
    install.packages("https://github.com/PrincetonUniversity/Rsafd/releases/latest/download/Rsafd.tar.gz", repos = NULL, type = "source", lib = lib)
    ```

In later sessions, repeat steps 1 and 2, then run `library(Rsafd)`.
