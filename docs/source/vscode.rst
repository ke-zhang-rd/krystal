======
vscode
======

settings.json
-------------

.. code:: JSON
 
  {
      "python.pythonPath": "/Users/<USERNAME>/miniconda3/envs/<CONDA_ENV>/bin/python"
  }

launch.json
-----------

.. code:: JSON

  {
      "version": "0.2.0",
      "configurations": [
          {
              "name": "Python Module",
              "type": "python",
              "python": "/Users/<USERNAME>/miniconda3/envs/<CONDA_ENV>/bin/python",
              "request": "launch",
              "program": "/Users/<USERNAME>/miniconda3/envs/<CONDA_ENV>/bin/<COMMAND>",
              "console": "integratedTerminal",
              "args": [
                  "hello-world"
              ],
              "cwd": "${workspaceRoot}",
              "<FOLDER_OR_PACKAGE>": true
          }
      ]
  }

If we translate to english.

* Go to ``cwd``.
* Use ``python`` to ``launch`` a launcher.
* Launcher run ``program`` with ``args`` which will run your command with args.
* The result will show on ``console``.
* This config is for ``FOLDER_OR_PACKAGE`` only, not whole workspace.

shortcut
--------

* choose Python Interpreter cmd+P
