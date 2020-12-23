==========
setuptools
==========


entrypoints
-----------

.. code:: python

  # setup.py in same directory of <PACKAGE>
  from setuptools import setup
  ...
  setup(

      ...
      entry_points={
          'console_scripts': ['<COMMAND>=<PACKAGE>.<MODULE>:<FUNCTION>'],
      },
      ...
  )

.. note::

  In addition to keyword ``console_scripts``, Setuptools supports ``gui_scripts``, which will launch a GUI application without running in a terminal window.
