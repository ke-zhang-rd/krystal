=========
functools
=========


lru_cache
---------

.. code:: python

  @functools.lru_cache(maxsize=128, type=False)

This decorator cached function call result in a dictionary based on LRU(least recent use). In next function call, it lookup the dictionary first and return result directly if it finds the key. 

  * ``maxsize`` control the size of the dictionary. If ``maxsize`` is None, it's keep growing up. 
  * ``typed`` controls whether type should be used to sperated different function call. If ``type=False``, e.g. ``1`` and ``1.0`` are treat as same parameters.

.. code:: python
   
  from functools import lru_cache
  import time

  # Function that computes Fibonacci
  # numbers without lru_cache
  def fib_without_cache(n):
    if n < 2:
      return n
    return fib_without_cache(n-1) + fib_without_cache(n-2)

  # Execution start time
  begin = time.time()
  fib_without_cache(30)

  # Execution end time
  end = time.time()

  print("Time taken to execute the\
  function without lru_cache is", end-begin)

  # Function that computes Fibonacci
  # numbers with lru_cache
  @lru_cache(maxsize = 128)
  def fib_with_cache(n):
    if n < 2:
      return n
    return fib_with_cache(n-1) + fib_with_cache(n-2)

  begin = time.time()
  fib_with_cache(30)
  end = time.time()

  print("Time taken to execute the \
  function with lru_cache is", end-begin)

.. code:: python
   
  Time taken to execute the function without lru_cache is 0.4448213577270508
  Time taken to execute the function with lru_cache is 2.8371810913085938e-05

cache
-----

.. code:: python

  @functools.cache(user_function)

``cache`` returns the same as ``lru_cache(maxsize=None)``.

cached_property
---------------

.. code:: python

  @functools.cached_property(func)

It's ``@cache`` + ``@property``. Transform a method of class into a property whose value is computed once and then cached as a normal attribute for the life of the instance.

wraps
-----

.. code:: python

  from functools import wraps
  
  def my_decorator(f):
      
      @wraps(f)
      def wrapper(*args, **kwds):
          print('Calling decorated function')
          return f(*args, **kwds)
      return wrapper

  @my_decorator
  def example():
      """Docstring"""
      print('Called example function')

  
  >>> example()
  Calling decorated function
  Called example function
  >>> example.__name__
  'example'
  >>> example.__doc__
  'Docstring'

``wraps`` manipulate ``__name__`` and ``__doc__`` for function(``example`` here).

partial
-------

.. code:: python

  from functools import partial

  def multiply(x,y):
          print('x', x)
          print('y', y)
          return x * y

  # create a new function that multiplies by 2
  dbl = partial(multiply,2)
  print(dbl(4))

