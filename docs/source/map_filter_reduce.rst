======================
Map, Filter and Reduce
======================

map
---
.. code:: python

  map(function_to_apply, list_of_inputs)

filter
------
.. code:: python

  number_list = range(-5, 5)
  less_than_zero = list(filter(lambda x: x < 0, number_list))
  print(less_than_zero)

reduce
------
.. code:: python

  from functools import reduce
  product = reduce((lambda x, y: x * y), [1, 2, 3, 4])
  24

