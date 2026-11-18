---
title: StackImages
layout: default
---

# Running StackImages

StackImages is a Python script and graphical interface for astrophotography image integration.

Two of its tools also run in your browser, with nothing to install:

- [Show Clusters](https://princetonuniversity.github.io/StackImages/ShowClusters/): Gaia star fields and HR diagrams.
- [HR Diagram of Your Own Image](https://princetonuniversity.github.io/StackImages/HRDiagram/): HR and color diagrams from your own FITS image.

## macOS

### Installation

Paste each command into the Terminal app.[^term]

1. Download and extract StackImages.
   ```
   curl -fL https://github.com/PrincetonUniversity/StackImages/releases/latest/download/PyWin.tar -o $HOME/Downloads/StackImages.tar && mkdir -p $HOME/Downloads/StackImages && tar -xvf $HOME/Downloads/StackImages.tar --directory=$HOME/Downloads/StackImages --strip-components=1 PyWin
   ```
2. Download and install Miniconda.
   ```
   curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-`arch`.sh -o ~/Downloads/miniconda.sh
   chmod +x ~/Downloads/miniconda.sh ; ~/Downloads/miniconda.sh -bu
   ```
3. Initialize conda, then quit and reopen Terminal.
   ```
   ~/miniconda3/bin/conda init bash ; ~/miniconda3/bin/conda init zsh
   ```
4. Accept the Terms of Service, set the channels (astropy, then apple, then conda-forge) and create the `BobsAstro` environment.
   ```
   conda tos accept
   conda config --add channels conda-forge --add channels apple --add channels astropy
   conda create -n BobsAstro astropy astroquery scipy==1.11.2 matplotlib wxpython opencv pyqt qt=5 imageio -y
   ```

### Running

Open Terminal, then run GetFit (downloads FITS images) or StackImages.

```
conda activate BobsAstro
pythonw $HOME/Downloads/StackImages/GetFit.py
pythonw $HOME/Downloads/StackImages/StackImages.py
```

### Updating

When told to update, run this to replace the StackImages files with the latest release.

```
curl -fL https://github.com/PrincetonUniversity/StackImages/releases/latest/download/PyWin.tar -o $HOME/Downloads/StackImages.tar && tar -xvkf $HOME/Downloads/StackImages.tar --unlink -C $HOME/Downloads/StackImages --strip-components=1 --exclude='._*'
```

## Windows

### Installation

1. [Download and install Miniconda](https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe), then open **Anaconda Prompt (Miniconda3)** from the Start menu. Paste each command below into it.
2. Download and extract StackImages.
   ```
   curl -fL --noproxy "*" https://github.com/PrincetonUniversity/StackImages/releases/latest/download/PyWin.tar -o %USERPROFILE%\Downloads\StackImages.tar && IF NOT EXIST %USERPROFILE%\Downloads\StackImages mkdir %USERPROFILE%\Downloads\StackImages && tar -xvf %USERPROFILE%\Downloads\StackImages.tar --directory=%USERPROFILE%\Downloads\StackImages --strip-components=1 PyWin
   ```
3. Accept the Terms of Service, set the channels (astropy, then conda-forge) and create the `BobsAstro` environment. OpenCV comes from pip, because conda's `opencv` fails to import on Windows.
   ```
   conda tos accept
   conda config --add channels conda-forge --add channels astropy
   conda create -n BobsAstro astropy astroquery scipy==1.11.2 matplotlib wxpython pyqt qt=5 imageio -y
   conda activate BobsAstro
   pip install opencv-contrib-python
   ```

### Running

Open Anaconda Prompt (Miniconda3), then run GetFit (downloads FITS images) or StackImages.

```
conda activate BobsAstro
pythonw %USERPROFILE%\Downloads\StackImages\GetFit.py
pythonw %USERPROFILE%\Downloads\StackImages\StackImages.py
```

### Updating

When told to update, run this to replace the StackImages files with the latest release.

```
curl -fL --noproxy "*" https://github.com/PrincetonUniversity/StackImages/releases/latest/download/PyWin.tar -o %USERPROFILE%\Downloads\StackImages.tar && tar -xvkf %USERPROFILE%\Downloads\StackImages.tar --unlink -C %USERPROFILE%\Downloads\StackImages --strip-components=1 --exclude=._*
```

## Start Over

To remove the environment, run the command below, then recreate it with the `conda create` step above.

```
conda env remove -n BobsAstro
```

[^term]: Terminal is in Applications → Utilities, or search for "Terminal".
