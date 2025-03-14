======
lambda
======

``lambda`` exapression is just a syntax suger for regular function definition.

.. code:: python

    func = lambda n: op(n)

could be translated to: 

.. code:: python

    def func(n):
        return op(n)

Packing exapression is legal in lambda expression.

.. code:: python

    func = lambda *args: op(args)

could be translate to: 

.. code:: python

    def func(*args):
        return op(args)

**Example:** sorting

.. code:: python

    >>> pairs = [(1, 'one'), (2, 'two'), (3, 'three'), (4, 'four')]
    >>> pairs.sort(key=lambda pair: pair[1])
    >>> pairs
    [(4, 'four'), (1, 'one'), (3, 'three'), (2, 'two')]

**Example:** default argument

.. code:: python

    >>> func = lambda a, b=3: (a, b)
    >>> func(2)
    (2, 3)

**Example:** unpacking operator

.. code:: python

    >>> out = lambda *x: list(map(str, x))
    >>> out('abc', 124)                                                         
    ['abc', '124']

.. note:: 

    As mentioned above,``lambda`` nothing but a syntax suger. So ``lambda`` could also accept ``*x`` as arguments, like regular function, when the number of arguments cannot be determined. Here ``x`` is unpacked to a tuple.
