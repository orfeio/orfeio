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
    curl -L https://vanderbei.princeton.edu/tmp/PyWin.tar -o $HOME/Downloads/StackImages.tar && if [[ ! -d $HOME/Downloads/StackImages ]]; then mkdir -p $HOME/Downloads/StackImages ; fi && tar -xvf $HOME/Downloads/StackImages.tar --directory=$HOME/Downloads/StackImages --strip-components=1 PyWin
	```
2. Download Miniconda.
    ```
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-`arch`.sh -o ~/Downloads/miniconda.sh
    ```
3. Install Miniconda.
    ```
    chmod +x ~/Downloads/miniconda.sh ; ~/Downloads/miniconda.sh -bu
    ```
4. Initialize Miniconda, then close and re-open the Terminal app.
    ```
    ~/miniconda3/bin/conda init bash ; ~/miniconda3/bin/conda init zsh
    ```
5. Accept the Terms of Service (TOS).
   ```
   conda tos accept
   ```
6. Configure the conda command to prioritize the Astropy channel first, the Apple channel second, and the Conda Forge channel third.
    ```
    conda config --add channels conda-forge --add channels apple --add channels astropy
    ```
7. Create a conda environment named `BobsAstro`.
    ```
    conda create -n BobsAstro astropy astroquery scipy matplotlib wxpython opencv pyqt qt=5 imageio -y
    ```

In order to use StackImages with astro images, use the included GetFit python program to download them.

1. Activate the `BobsAstro` environment.
   ```
   conda activate BobsAstro
   ```
2. Run the GetFit program and utilize it as instructed.
   ```
   pythonw $HOME/Downloads/StackImages/GetFit.py
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

1. [Download and install Miniconda](https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe).
2. Open the Anaconda Prompt (Miniconda3) by finding it within the Windows (logo) Menu or by searching for it by name.
3. Download and extract StackImages.
   ```
   curl --noproxy "*" https://vanderbei.princeton.edu/tmp/PyWin.tar -o %USERPROFILE%\Downloads\StackImages.tar && IF NOT EXIST %USERPROFILE%\Downloads\StackImages mkdir %USERPROFILE%\Downloads\StackImages && tar -xvf %USERPROFILE%\Downloads\StackImages.tar --directory=%USERPROFILE%\Downloads\StackImages --strip-components=1 PyWin
   ```
5. Configure the conda command to prioritize the Astropy channel first, then the Conda Forge channel.
    ```
    conda config --add channels conda-forge --add channels astropy
    ```
6. Accept the Terms of Service (TOS).
   ```
   conda tos accept
   ```
7. Create a conda environment named `BobsAstro`.
    ```
    conda create -n BobsAstro astropy astroquery scipy matplotlib wxpython pyqt qt=5 imageio -y

    ```
8. Activate the `BobsAstro` conda environment.
   ```
   conda activate BobsAstro
   ```
9. Install the `opencv` module via the `pip` command.[^cv2issue]
   ```
   pip install opencv-contrib-python
   ```
10. Close the Anaconda Prompt.

In order to use StackImages with astro images, use the included GetFit python program to download them.

1. Activate the `BobsAstro` environment.
   ```
   conda activate BobsAstro
   ```
2. Run the GetFit program and utilize it as instructed.
   ```
   pythonw %USERPROFILE%\Downloads\StackImages\GetFit.py
   ```

Each time you wish to work with and run StackImages, open the Anaconda Prompt (Miniconda3) app and then run the following commands.

1. Activate the `BobsAstro` conda environment.
    ```
    conda activate BobsAstro
    ```
2. Run StackImages.
    ```
    pythonw %USERPROFILE%\Downloads\StackImages\StackImages.py
    ```

[^term]: You can find the Terminal app inside the Utilities folder found within the Applications folder, or search for "Terminal".
[^cv2issue]: On Windows as of this writing, the `opencv` package will install via `conda` but then fails on import with an ImportError, indicating a DLL is not found.  Rather than address the issue directly, we install the extra dependency via `pip`.
