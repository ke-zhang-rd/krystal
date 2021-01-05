=========
Decorator
=========

Syntax
------

.. code:: python
  
  @dec
  def foo(...):
    ...
 
  # Still called by
  >>> foo()

``@`` is a syntax sugar. The **true meaning** of syntax is: 

.. code:: python
  
  foo = dec(foo)

  >>> foo()

.. attention::

  This syntax sugar assignment is executed during decorated function definition not on function call.

Decorator doesn't mean to change function name. So the thing after ``@`` has to be a function which accepts a **func** and return a **new func**. Decorator also accept arguments.

.. code:: python
  
  @dec(param=something)
  def func(...):
    ...
  
  >>> func()

True meaning is:

.. code:: python

  newdec = dec(param=something)
  func = newdec(func)

  >>> func()

It reveals the logic under the hood is calculating function call ``dec(a=something)`` first which returns the true decorator.

Chained decorators
------------------

.. code:: python

  @outside
  @inside
  def func(...):
    ...

Again, this will translate to thing below during ``func()`` call. So intuitively, the rule is parsing the inside decorator first and then outside.

.. code:: python

  func = outside(inside(func))

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

1. ``newfunc`` is a wrapper of ``func``, so ``func`` will be called inside ``newfunc``.
2. ``newfunc`` need to pass any arguments it accepts to ``func``. So ``*args`` and ``**kwargs`` should be used.

#1 will make it looks like:

.. code:: python

  def dec(func):
      ...
      def newfunc(...):
          ...
          func(...)
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

Write a decorator with parameters
---------------------------------

Again, It runs the function with parameters first and return true decorator. So the defination looks like

.. code:: python

  def dec(param):
    
    # Write a decorator defination inside and return it.

    return newdec

So it will looks like.(``...`` might involve using ``param``).

.. code:: python

  def dec(param):
    ...
    def newdec(func) 
      ...
      def newfunc(*arg, **kwargs)
        ...
        func(*arg, **kwargs)
        ...
      return newfunc
      ...
    ...
    return newdec

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
