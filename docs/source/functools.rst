=========
functools
=========

@functools.lru_cache
@functools.cache
@functools.cached_property
https://docs.python.org/3/library/functools.html
functools.partial
functools.reduce
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

.. code:: python

  In [14]: from functools import reduce                                           
  In [15]: func = lambda s, t: s.replace(*t)                                      
  In [16]: reduce(func, [('a','b'), ('c', 'd')], 'abc')                           
  Out[16]: 'bbd'

