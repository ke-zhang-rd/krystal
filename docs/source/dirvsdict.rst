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

.. code:: ipython

    In [1]: c=C()
    1
    In [2]: dir(c)
    Out[2]:
    [....
    ...
     'a',
     'p']

    In [3]: c.__dict__
    Out[3]: {'a': 'a'}

    In [4]: c.p = 3
    In [5]: c.__dict__
    Out[5]: {'a': 'a', 'p': 3}


.. note::

    Here ``c.p`` assignment make ``p`` becomes an instance attribute.
