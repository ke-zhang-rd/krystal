===
zip
===

The true name of zip is **transpose**.
| When you want to choose certain index of each element in ``*arg`` and group them together, you need zip. Somehow, this is a transpose operation.

If you think each row is a parameter of zip, then zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9]) is in a format of:

.. code-block:: python

  [0, 1, 2, 3, 4], 
  [5, 6, 7, 8, 9]

zip will transpose it to:

.. code-block:: python

  [0, 5],
  [1, 6],
  [2, 7],
  [3, 8],
  [4, 9]

.. code-block:: python

  In [19]: list(zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9]))                            
  Out[19]: [(0, 5), (1, 6), (2, 7), (3, 8), (4, 9)]

Transpose is inversive meaning (AT)T = A. Below is an example showing this feather:

.. code-block:: python

  In [18]: list(zip(*list(zip([0, 1, 2, 3, 4], [5, 6, 7, 8, 9]))))                
  Out[18]: [(0, 1, 2, 3, 4), (5, 6, 7, 8, 9)]

