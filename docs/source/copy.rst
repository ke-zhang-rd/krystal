========================
Deepcopy vs Shallow copy
========================

Shallow copy
------------

Shallow copy, means not deep enough, means internal object isn't copied. Object in both old container and new container will change together.
``obj`` will change together in ``obj``, ``var`` and ``var_cp`` in below example.

.. tip::

  *Internal objects* (objects that contain other objects, like lists or class instances)

  .. code:: python

    interanl = {'a': 3}
    ls = [internal, 1, 2, 3]

  Here ``internal`` is an internal object.

Example:

.. code:: python
    
    obj = {'a': 3}
    var = [obj, 1, 2, 3]
    var_cp = var[:]
    obj['a'] = 4

.. code:: python
    
    >>> var
    >>> var_cp
    [{'a': 4}, 1, 2, 3]
    [{'a': 4}, 1, 2, 3]
    >>> var is var_cp
    False
    >>> var == var_cp
    True

Deep copy
---------

Deepcopy create totally independent object from top to bottom.

You could do ``deepcopy`` by builtin module ``copy``.

.. code:: python
  
  from copy import deepcopy
  obj = {'a':1}
  var = [obj, 1, 2, 3]
  var_dpcp = deepcopy(var)
  var[0]['a'] = 2

  >>> var_dpcp
  [{'a': 1}, 1, 2, 3]
  >>> var is var_dpcp
  False
  >>> var == var_dpcp
  True


Reference
---------

Reference is just a alternative name of orignal object. Assignment create a reference.

.. code:: python

  obj = {'a':1}
  var = [obj, 1, 2, 3]
  var_ref = var
  var[1] = -1
  var[0]['a'] = 2

.. code:: python
  
  >>> var_ref
  [{'a': 2}, -1, 2, 3]
  >>> var is var_ref
  True

.. tip::

  +-------------+--------------------------+
  | **operator**| **meaning**              |
  +=============+==========================+
  | ``==``      | equal                    |
  +-------------+--------------------------+
  | ``!=``      | not equal                |
  +-------------+--------------------------+
  | ``is``      | object identity          |
  +-------------+--------------------------+
  | ``is not``  | negative object identity |
  +-------------+--------------------------+
