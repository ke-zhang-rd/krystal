======
import
======


When you use ``import``, python first checks ``sys.modules`` to see if the module/pkg has been imported already.

If not, it will try import based on the directories of ``sys.path``.

* If it’s a **pkg**, it will run the ``__init__.py``.
* If it’s a **module**, it will run the whole file.

if yes, it won’t re-run the file no matter it is pkg(``__init__.py``) or module file.

Let’s say you have the following directory structure:


.. code-block:: none
 
  └── project
      ├── package1
      │   ├── module1.py
      │   └── module2.py
      └── package2
          ├── __init__.py
          ├── module3.py
          ├── module4.py
          └── subpackage1
              └── __init__.py
              └── module5.py

| Let’s assume the following:

* package1/module2.py contains a function, function1.
* package2/__init__.py contains a class, class1.
* package2/subpackage1/module5.py contains a function, function2.

.. code-block:: python

  from package1 import module1       
  # There isn’t __init__.py file, so skip it. This will run whole module1.py.
  from package1.module2 import function1
  # This will run package1(__init__.py) and whole module2.py
  from package2 import class1
  # This will run package2’s __init__.py
  from package2.subpackage1.module5 import function2
  # This will skip package2’s __init__.py since it has been imported. It could be verified by sys.modules. It will run subpackage2’s __init__.py and then whole module5.py

