---
title: Gurobi & Python
layout: default 
---

# Gurobi & Python

[Gurobi](http://gurobi.com) is mathematical optimization software, a suite of solvers for mixed-integer and linear programming problems.

Academic licensing exists for individuals and institutions; the clusters [have an installation](https://researchcomputing.princeton.edu/support/knowledge-base/julia#gurobi) that uses an institutional license.

## Jupyter Notebooks

In order to utilize Gurobi from a Jupyter notebook via Python, you need a complete installation of Gurobi[^ginst], Python, Jupyter, and the `gurobipy` module in your Python environment, as well as a valid license file.

## Setup

For software projects, it is good practice to use a tool to manage packages and dependencies.  The [conda command](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html) ships with Anaconda and Miniconda, [among others](https://github.com/mamba-org/mamba), and is [favored on the clusters](https://researchcomputing.princeton.edu/support/knowledge-base/python#versus).

We will use this tool to set up our project.

1. Access the cluster environment via a shell.[^adroitreg]

2. Load Anaconda via the [Environment Modules](https://researchcomputing.princeton.edu/support/knowledge-base/modules) system.  For this example, we will use version 2023.3.
    ```
    module load anaconda3/2023.3
    ```

    {: .warning }
    Anaconda prefixes your shell prompt with the name of the current Anaconda environment.  The "base" environment is the default, but you should [never work in the "base"](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html). The next few steps address this.

3. Create a conda environment.
   
    This command downloads most of Gurobi and the `gurobipy` module from the `gurobi` [conda channel](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/channels.html), as well as the `ipykernel` module, which allows Jupyter to talk to Python.  For this example, the environment is named `gpyproject`, which you can change to any name you'd like.
    ```
    conda create -y --name gpyproject --channel gurobi gurobi ipykernel
    ```

    {: .note }
    The clusters have an [existing Gurobi installation](https://researchcomputing.princeton.edu/support/knowledge-base/julia#gurobi), so this is a little redundant, but it simplifies reproducibility of our development environment. 

4. Visit the web interface for the cluster and select *Jupyter* under the *Interactive Apps* menu.

5. Select the proper Anaconda version for the "Anaconda3 version used for starting up jupyter interface" option, noting that our example above used 2023.3.

6. Click Launch.  Once your session is allocated a button labeled "Connect to Jupyter" will appear.

7. Click the New button within Jupyter and select the option that includes the environment name.  Our example used `gpyproject`.

8. Test Gurobi.  I like formulating and solving a simple MIP model.

    ```
    from gurobipy import *
    try:
        # Create a new model
        m = Model("mip1")
        # Create variables
        x = m.addVar(vtype=GRB.BINARY, name="x")
        y = m.addVar(vtype=GRB.BINARY, name="y")
        z = m.addVar(vtype=GRB.BINARY, name="z")
        # Set objective
        m.setObjective(x + y + 2 * z, GRB.MAXIMIZE)
        # Add constraint: x + 2 y + 3 z <= 4
        m.addConstr(x + 2 * y + 3 * z <= 4, "c0")
        # Add constraint: x + y >= 1
        m.addConstr(x + y >= 1, "c1")
        m.optimize()
        for v in m.getVars():
            print('%s %g' % (v.varName, v.x))
        print('Obj: %g' % m.objVal)
    except GurobiError as e:
        print('Error code ' + str(e.errno) + ": " + str(e))
    except AttributeError:
        print('Encountered an attribute error')
    ```

    The output should look something like this.

    ```
    Restricted license - for non-production use only
    Gurobi Optimizer version 10.0.1 build v10.0.1rc0 (linux64)
    Optimize a model with 2 rows, 3 columns and 5 nonzeros
    Model fingerprint: 0x98886187
    Variable types: 0 continuous, 3 integer (3 binary)
    Coefficient statistics:
      Matrix range     [1e+00, 3e+00]
      Objective range  [1e+00, 2e+00]
      Bounds range     [1e+00, 1e+00]
      RHS range        [1e+00, 4e+00]
    Found heuristic solution: objective 2.0000000
    Presolve removed 2 rows and 3 columns
    Presolve time: 0.00s
    Presolve: All rows and columns removed
    
    Explored 0 nodes (0 simplex iterations) in 0.01 seconds (0.00 work units)
    Thread count was 1 (of 64 available processors)

    Solution count 2: 3 2 
    
    Optimal solution found (tolerance 1.00e-04)
    Best objective 3.000000000000e+00, best bound 3.000000000000e+00, gap 0.0000%
    x 1
    y 0
    z 1
    Obj: 3
    ```

[^ginst]: A complete installation of Gurobi should include modifications to the sourced environment that set values for the variables `GRB_LICENSE_FILE` and `GUROBI_HOME`, and prepend the location of `$GUROBI_HOME/bin` to the PATH and `$GUROBI_HOME/lib` to `LD_LIBRARY_PATH`.
[^adroitreg]: You'll need to [have been granted access to Adroit](https://researchcomputing.princeton.edu/systems/adroit#access) or one of the other clusters in order to do so.
