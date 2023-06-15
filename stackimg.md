---
title: StackImages
layout: default 
---

# Running StackImages

StackImages is a Python script and graphical interface for astrophotography image integration.

## macOS

Paste each of the following commands into the Terminal app[^term] to download StackImages and prepare your device to run it.

1. Download and extract StackImages.
	```
    curl https://vanderbei.princeton.edu/tmp/PyWin.tar -o $HOME/Downloads/StackImages.tar && if [[ ! -d $HOME/Downloads/StackImages ]]; then mkdir -p $HOME/Downloads/StackImages ; fi && tar -xvf StackImages.tar --directory=$HOME/Downloads/StackImages --strip-components=1 PyWin
	```
2. Download Miniconda.
    ```
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/Downloads/miniconda.sh
    ```
3. Install Miniconda.
    ```
    chmod +x ~/Downloads/miniconda.sh ; ~/Downloads/miniconda.sh -bu
    ```
4. Initialize Miniconda, then close and re-open the Terminal app.
    ```
    ~/miniconda3/bin/conda init bash ; ~/miniconda3/bin/conda init zsh
    ```
5. Configure the conda command to prioritize the Astropy channel first, the Apple channel second, and the Conda Forge channel third.
    ```
    conda config --add channels conda-forge --add channels apple --add channels astropy
    ```
6. Create a conda environment named `BobsAstro`.
    ```
    conda create -n BobsAstro astropy astroquery scipy matplotlib wxpython opencv pyqt -y
    ```
Each time you wish to work with and run StackImages, open the Terminal and then run the following commands.

1. Activate the `BobsAstro` environment.
    ```
    conda activate BobsAstro
    ```

2. Run StackImages.
	```
	pythonw $HOME/Downloads/StackImages/StackImages.py
	```


## Windows

1. Download and extract StackImages.
	```
	MISSING
	```
2. [Download and install Miniconda](https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe).
3. Open the Anaconda Prompt (Miniconda3) by finding it within the Windows (logo) Menu or by searching for it by name.
4. Configure the conda command to prioritize the Astropy channel first, then the Conda Forge channel.
    ```
    conda config --add channels conda-forge --add channels astropy
    ```
4. Create a conda environment named `BobsAstro`.
    ```
    conda create -n BobsAstro astropy astroquery scipy matplotlib wxpython opencv pyqt -y
    ```
5. Close the Anaconda Prompt.

Each time you wish to work with and run StackImages, open the Anaconda Prompt (Miniconda3) app and then run the following commands.

1. Activate the Renv conda environment.
    ```
    conda activate BobsAstro
    ```
2. Run StackImages.
	```
	MISSING
	```

[^term]: You can find the Terminal app inside the Utilities folder found within the Applications folder, or search for "Terminal".