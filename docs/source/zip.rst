===
zip
===


.. code-block:: python

    zip(*iterables)

| The true name of zip is **transpose**.
| When you want to choose certain index of each element in ``iterables`` and group them together, you need zip. Somehow, I feel it is transpose operation.

If you think each row is a parameter of zip, then zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9]) is in a format of:

.. code-block:: python

  [0, 1, 2, 3, 4], 
  [5, 6, 7, 8, 9]

zip will **transpose** it to:

.. code-block:: python

  [0, 5],
  [1, 6],
  [2, 7],
  [3, 8],
  [4, 9]

**Example**

.. code-block:: python

  >>> list(zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9]))                            
  [(0, 5), (1, 6), (2, 7), (3, 8), (4, 9)]

**Example:** inversive

Transpose is inversive which meaning :math:`({A^T})^T = A`. Below is an example showing this feather of zip:

.. code-block:: python

  >>> res = list(zip(*(zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9]))))                
  >>> list(res)
  [(0, 1, 2, 3, 4), (5, 6, 7, 8, 9)]

.. note:: 

   * ``zip`` takes ``*iterables`` as arguments which are argument seperated by comma.
   * The star in ``zip(*zip(...`` unpack zip object to iterable
   * list() is needed to explicit get zip result.