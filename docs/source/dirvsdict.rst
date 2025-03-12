===============
dir vs __dict__
===============

  * ``dir``: return a list including instance and class attributes
  * ``__dict__``: return a dictionary which are instance attributes and its value.

**Example**

.. code:: python

    class C:
        var = 1
        def __init__(self):
            print(self.var)
            self.attr = "value"

.. code:: python

    >>> obj=C()
    1
    
    >>> dir(obj)
    [....
    ...
     'var',
     'attr']

    >>> obj.__dict__
    {'attr': 'value'}

    >>> obj.var = 3
    >>> obj.__dict__
    {'attr': 'value', 'var': 3}


.. note::

    Here the assignment of ``obj.var`` make ``var`` becomes an instance attribute.
