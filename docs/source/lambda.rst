======
Lambda
======

Example:

.. code-block:: python

    >>> pairs = [(1, 'one'), (2, 'two'), (3, 'three'), (4, 'four')]
    >>> pairs.sort(key=lambda pair: pair[1])
    >>> pairs
    [(4, 'four'), (1, 'one'), (3, 'three'), (2, 'two')]

Example:

.. code-block:: python

    >>> out = lambda *x: print(list(map(str, x)))
    >>> out('abc', 124)                                                         
    ['abc', '124']

In second example, you may notice that ``lambda`` also accept ``*x`` as arguments if you are not sure the number of arguments. Here ``x`` is a tuple.
