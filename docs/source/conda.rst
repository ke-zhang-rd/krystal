=========================
Conda Virtual Environment
=========================

Create environment

.. code:: bash

  conda create -n myenv python=3.6

List environment

.. code:: bash

  conda create -n myenv python=3.6

Remove environment

.. code:: bash

  conda remove --name myenv --all

Activate environment

.. code:: bash

  conda activate myenv

Deactivate environment

.. code:: bash

  conda deactivate 

List all packages

.. code:: bash

  conda list

Search packages

.. code:: bash

  conda search -c conda-forge numpy

Install package from certain channel

.. code:: bash

  conda install -c conda-forge numpy

Export current environment info

.. code:: bash

  conda env export > environment.yml
