========================
Deepcopy vs shallow copy
========================

**Compound objects** (objects that contain other objects, like lists or class instances)

.. code:: python

  interanl = {'a': 3}
  ls = [internal, 1, 2, 3]

Here ``internal`` is a compound object.

**Shallow** copy is shallow which means internal compound object isn’t copied and both in old container and new container will change together.
``obj`` will change together in ``obj``, ``var`` and ``var_cp`` in below example.

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

**Deepcopy** is just totally independent.

You could ``deepcopy`` by pkg ``copy``

.. code:: python

  obj = {'a':1}
  var = [obj, 1, 2, 3]
  var_dpcp = deepcopy(ls)
  var[0]['a'] = 2

.. code:: python

  >>> var_dpcp
  [{'a': 1}, 1, 2, 3]
  >>> var is var_dpcp
  False
  >>> var == var_dpcp
  True


**Reference** is taling about exactly same thing. Everything change together.

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
