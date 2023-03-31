---
title: Python Wrappers
layout: default 
nav_order: 3
---

# Python Wrappers

In the course of Python development, you may find that successfully installing and importing a given module is not sufficient to execute code.

If the module you are trying to utilize is described as a wrapper or said to use Python bindings, the module likely wraps a lower-level language and/or has dependencies external to Python.

## General Guidance

For our purposes, there are two common scenarios: web automation or incorporating a more performant module written in a lower-level language.

First, read through the module's description to determine what external software component is required.  There may be further guidance as part of the documentation, indicating how to satisfy the requirements.

Next, determine whether or not the software is available as compiled binaries and libraries, source code, or both.[^compint]

Lastly, and whenever possible, try to satisfy the requirements using your existing environment manager, or a software management tool called from within your environment.  

## Practical Examples: Web Automation & Performant Analysis

We can step through the two common scenarios to offer some insight into how to apply the guidance.  For the purpose of the examples, we will assume [management of two Python projects via conda](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html).

The web automation project will run on a local device such as a laptop.  The analysis project will run on a remote, [server environment](https://myadroit.princeton.edu).  The web automation project will require the use of a precompiled binary, while the analysis project will require compiling code from the external project's code before it is ready for use.

### Web Automation Example

A good place to start with web automation is with the `selenium` module.  The [Selenium Downloads page](https://www.selenium.dev/downloads/) refers to the Python module under a "Language Bindings" section header, which is our clue that importing the module is not sufficient.

#### Steps

1. Create a new `conda` environment and include the `selenium` and `jupyter` modules from the `conda-forge` channel.  For this example, we will name our environment `webauto`.
    ```
	conda create -y --channel conda-forge --name webauto selenium jupyter
    ```
    
    {: .note }
    The `conda` environment manager satisfies dependencies for both `selenium` and `juypter`; we need not specify `python` as neither will work without it.  However, while we can `import selenium`, the package manager fails to indicate that it is useless without our external binary.

2. Activate the new environment with `conda activate webauto`, then open a new jupyter notebook via `jupyter notebook`.  In your notebook `from selenium import webdriver`, then attempt to instantiate a new driver.
   ```
   from selenium import webdriver
   driver = webdriver.Chrome()
   ```

    {: .warning }
	This step should raise an exception akin to `selenium.common.exceptions.WebDriverException: Message: executable needs to be in PATH.`.  The `PATH` is an environment variable stores the locations of executable binaries.  We do not have all the pieces we need.

3. Exit Jupyter and return to a Terminal.  From within your `webauto` environment, install the `webdriver-manager` module.  The `webdriver-manager` module is an example of a module that will help us supply the correct binary for `selenium`, essentially doing the job of environmental management for the component that `conda` does not satisfy.[^piptoo]
    ```
    conda install -y --channel conda-forge webdriver-manager
    ```

4. Open Jupyter once again.  This time, we will also import `webdriver_manager` [per the module repository documentation](https://github.com/SergeyPirogov/webdriver_manager).  Calling `.install()` causes `webdriver_manager` to download a pre-compiled binary for our device, save it to our environment, and use it automatically as we work with the instantiated `driver` object. 
    ```
    from selenium import webdriver
    from selenium.webdriver.chrome.service import Service as ChromeService
    from webdriver_manager.chrome import ChromeDriverManager

    driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))
    ```

### Analysis Example

For the purpose of the analysis example we will use TA-Lib, which performs technical analysis of financial market data.  At first blush, it looks as if TA-Lib lives at [multiple](https://pypi.org/project/TA-Lib/), [authoritative](https://ta-lib.org) locations with either differing descriptions or [none at all](https://anaconda.org/conda-forge/ta-lib).

{: .warning }
The TA-Lib software is also available as prepackaged binaries via `conda` under the name `libta-lib`, possibly also via `ta-lib`.  While these example steps are a useful demonstration of satisfying an external dependency, you are better off using `conda install -c conda-forge libta-lib` and getting right to work instead.

We can see that [at least one source](https://pypi.org/project/TA-Lib/) describes TA-Lib as, "a Python wrapper for [TA-LIB](https://ta-lib.org)(sic)", so we have our clue that TA-Lib in a Python context is a wrapper for some other code.

{: .note }
We can further confirm TA-Lib is living a double life by visiting the referenced <https://ta-lib.org> site and seeing that the project contains an, "Open-source API for C/C++, Java, Perl, Python" allowing us to interface with it from other languages.  Additionally, the [TA-Lib Downloads page](https://ta-lib.org/hdr_dw.html) doesn't contain anything resembling a Python package.

#### Steps

1. On the server [via an interactive shell](https://myadroit.princeton.edu/pun/sys/shell/ssh/adroit), load the Anaconda module with the command `module load anaconda3/2023.3` and create a new `conda` environment with only `pip` and its dependencies.
    ```
	conda create -y --channel conda-forge --name analysis pip
    ```

2. Activate the `analysis` environment via `conda activate analysis` and try using `pip` to install the `ta-lib` module via `pip install ta-lib`.

    {: .warning }
    Attempting to install `ta-lib` via `pip` should fail with an error that, in part, reads "ERROR: Could not build wheels for ta-lib" from `gcc`, the default C compiler.  The wrapper tries to also satisfy our external requirement, but fails.

3. Since installation of the `ta-lib` package fails with the `pip` package manager, we will download and install both the TA-Lib software and the Python package manually.

    1. [Download the TA-Lib source code](https://ta-lib.org/hdr_dw.html) (tar.gz) and transfer the file to Adroit.
    
    2. Clone the repository for `ta-lib-python`.
    ```
    git clone https://github.com/TA-Lib/ta-lib-python.git
    ```
    
    3. 

[^compint]: [Interpreted vs Compiled Programming Languages: What's the Difference?](https://www.freecodecamp.org/news/compiled-versus-interpreted-languages/)
[^piptoo]: A more familiar example of environment management from within the `conda` would be `pip`.  If `conda` cannot supply a given Python module, try installing `pip` inside the `conda`-managed environment (`conda install pip`) and then proceed to install the module via `pip` from within!
[^tricky]: The missing dash is not a typo.  The package name for a module need not match the name used for imports.