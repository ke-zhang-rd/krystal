===============
dir vs __dict__
===============

``dir`` looks at your class attributes and instance attributes while ``__dict__`` only check your instance available attributes.

  * ``dir``: instance and class attributes
  * ``__dict__``: instance attributes

Example:

.. code:: python

    class C:
        p = 1
        def __init__(self):
            print(self.p)
            self.a = 'a'

.. code:: python

    In [9]: c=C()
    In [10]: dir(c)
    Out[10]:
    [....
    ...
     'a',
     'p']

    In [11]: c.__dict__
    Out[11]: {'a': 'a'}

    In [5]: c.p = 3
    In [7]: c.__dict__
    Out[7]: {'a': 'a', 'p': 3}


.. note::

    Here ``c.p`` assignment make ``p`` becomes an instance attribute.
