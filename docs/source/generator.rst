===============================
Generator, yield and yield from
===============================

yield
-----

**Syntax**

.. code:: python

  variable = yield value

variable is assigned by ``gen.send()``

yield expression
----------------

A generator expression is a compact generator notation in parentheses:
generator_expression = (expression comp_for)
A generator expression yields a new generator object. Its syntax is the same as for comprehensions, except that it is enclosed in parentheses instead of brackets or curly braces.

yield from
----------

The true name of ``yield from`` is ``for`` loop. It allows the user to delegate tasks to another generator. Additionally, the subgenerator is allowed to return with a value, and the value is made available to the delegating generator. example:

.. code:: python
  
  def gen1(): 
      for i in range(10):
          yield i                                                                                                  

  gen2 = lambda: (i for i in range(10,20))

  def gen(): 
      for i in gen1(): 
          yield i 
      for i in gen2(): 
          yield i                                                                                              

  >>> list(gen())                                                                                          
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]

.. code:: python

  def gen(): 
      yield from gen1() 
      yield from gen2() 

  >>> list(gen())                                                                                          
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]

.. code:: python

  lamyield = lambda: (x for x in range(15))                                                             
  >>> print(*lamyield())                                                                                    
  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14

Even yield from designed to yield from another generator, however, it allows any iterator, example:


.. code:: python

  def g(x):
      yield from range(x, 0, -1)
      yield from range(x)

  >>> list(g(5))
  [5, 4, 3, 2, 1, 0, 1, 2, 3, 4]
