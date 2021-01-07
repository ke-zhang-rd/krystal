======================
Map, Filter and Reduce
======================

All those three functions has similar syntax as shown below.

.. code:: python

  map(function_to_apply, list_of_inputs)

map
---
.. code:: python

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

**Example 1:**

.. code:: python

  from functools import reduce
  product = reduce((lambda x, y: x * y), [1, 2, 3, 4])
 
  >>> product
  24

**Example 2:**

.. code:: python

  from functools import reduce                                           
  func = lambda s, t: s.replace(*t)                                      
  
  >>> reduce(func, [('a','b'), ('c', 'd')], 'abc')                           
  'bbd'

It’s definition roughly equivalent to:

.. code:: python

  def reduce(function, iterable, initializer=None):
      it = iter(iterable)
      if initializer is None:
          value = next(it)
      else:
          value = initializer
      for element in it:
          value = function(value, element)
      return value
