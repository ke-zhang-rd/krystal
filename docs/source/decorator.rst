=========
Decorator
=========

True meaning
------------

``@`` is a syntax sugar.

.. code:: python
  
  @dec
  foo()

True meaning is:

.. code:: python
  
  foo = dec(foo)

So the thing after ``@`` has to be a function which accepts a func and return a new func.

.. code:: python
  
  @dec(a=something)
  foo()

True meaning is:

.. code:: python
  
  tmp = dec(a=something)

  @tmp
  foo()

Need to calculate function call ``dec(a=something)`` first which returns the true decorator.

Write a decorator
-----------------

When you try to write a decorator ``dec``, **it accepts a func and returns a func**. So initially, it should looks like:

.. code:: python

  def dec(func):
    ...
    return f

``f`` is a function which needs to be defined inside dec. So it looks like:

.. code:: python

  def dec(func):
      ...
      def f(...):
          ...
      return f

Since we return ``f`` and ``f`` is the function we will use later, this reveal two considerations:

1. ``f`` need to pass any arguments it accepts to ``func``. So ``*args`` and ``**kwargs`` should be used.
2. ``f`` is a wrapper of ``func``, so ``func`` will be called inside ``f``.

#1 will make it looks like:

.. code:: python

  def dec(func):
      ...
      def f(*args, **kwargs):
          ...
      return f

#2 will make it looks like:

.. code:: python

  def dec(func):
      ...
      def f(*args, **kwargs):
          ...
          func(*args, **kwargs)
          ...
      return f

Eventually, it becomes:

.. code:: python

  def dec(func):
      def f(*arg, **kwargs):
          print('calling func')
          func(*arg, **kwargs)
          print('end func')
      return f

  @dec
  def foo():
      print('abc')
    
  >>> foo()
  calling func
  abc
  end func

Class decorator
---------------

Class decorator is nothing more. If a function’s decorator is a function that accepts a function and returns a new function. Then class’s decorator is a function that accepts a class and returns a new class.

.. code:: python

  def dec(cls):
      class newcls(cls):
          attr = 100
      return newcls

  @dec
  class X:
      pass

  >>> x = X()
  >>> X.attr
  100
