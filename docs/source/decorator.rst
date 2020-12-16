=========
Decorator
=========

**True meaning**

The syntax of decorator:

.. code:: python
  
  @dec
  foo()
  
  >>> foo()

``@`` is a syntax sugar. The true meaning of syntax is: 

.. code:: python
  
  foo = dec(foo)

So the thing after ``@`` has to be a function which accepts a **func** and return a **new func**.

.. code:: python
  
  @dec(a=something)
  foo()

True meaning is:

.. code:: python
  
  tmp = dec(a=something)

  @tmp
  foo()

  >>> foo()

Need to calculate function call ``dec(a=something)`` first which returns the true decorator.

Write a decorator
-----------------

When you try to write a decorator ``dec``, Keep in mind: **it accepts a func and returns a func**. So initially, it should looks like:

.. code:: python

  def dec(func):
    ...
    return newfunc

``newfunc`` is a function which needs to be defined inside ``dec``. So it looks like:

.. code:: python

  def dec(func):
      ...
      def newfunc(...):
          ...
      return newfunc

Since we return ``newfunc`` and ``newfunc`` is the function we will use later, this reveal two considerations:

1. ``newfunc`` need to pass any arguments it accepts to ``func``. So ``*args`` and ``**kwargs`` should be used.
2. ``newfunc`` is a wrapper of ``func``, so ``func`` will be called inside ``newfunc``.

#1 will make it looks like:

.. code:: python

  def dec(func):
      ...
      def newfunc(*args, **kwargs):
          ...
      return newfunc

#2 will make it looks like:

.. code:: python

  def dec(func):
      ...
      def newfunc(*args, **kwargs):
          ...
          func(*args, **kwargs)
          ...
      return newfunc

Eventually, a runable decorator example shows below:

.. code:: python

  def dec(func):
      def newfunc(*arg, **kwargs):
          print('calling func')
          func(*arg, **kwargs)
          print('end func')
      return newfunc

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
  class C:
      pass

  >>> obj = C()
  >>> C.attr
  100
