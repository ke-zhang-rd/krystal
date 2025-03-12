===
zip
===


.. code:: python

    zip(*iterables)

| The real name of ``zip`` is **transpose**.
| If you try to choose certain indices of each element in ``iterables`` and group them together, you need ``zip``. It is transpose operation.

Thinking arguments of zip as a matrix, each argument is a row. Then ``[0, 1, 2, 3, 4], [5, 6, 7, 8, 9]`` looks like

.. code:: python

  [0, 1, 2, 3, 4], 
  [5, 6, 7, 8, 9]

``zip`` will **transpose** it to:

.. code:: python

  [0, 5],
  [1, 6],
  [2, 7],
  [3, 8],
  [4, 9]

**Example**

.. code:: python

  >>> list(zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9])) 
  [(0, 5), (1, 6), (2, 7), (3, 8), (4, 9)]

**Example:** inversive

Transpose is inversive which means :math:`({A^T})^T = A`. Here is an example showing this feather of ``zip``:

.. code:: python

  >>> res = list(zip(*(zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9])))) 
  >>> list(res)
  [(0, 1, 2, 3, 4), (5, 6, 7, 8, 9)]

.. note:: 

   * ``zip`` takes ``*iterables`` as arguments which are argument seperated by comma.
   * The star in ``zip(*zip(...`` unpack zip object to iterable.
   * ``list()`` is needed to explicit get zip result.
