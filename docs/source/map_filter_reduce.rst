======================
Map, Filter and Reduce
======================

map
---
.. code-block:: python

  # map(function_to_apply, list_of_inputs)
  numbers = [1, 2, 3, 4]
  result = map(lambda x: x + x, numbers) 
  
  >>> list(result)
  [2, 4, 6, 8]

filter
------
.. code:: python

  number_list = range(-5, 5)
  less_than_zero = list(filter(lambda x: x < 0, number_list))

  >>> less_than_zero
  [-5, -4, -3, -2, -1]


reduce
------
.. code:: python

  from functools import reduce
  product = reduce((lambda x, y: x * y), [1, 2, 3, 4])
 
  >>> product
  24

