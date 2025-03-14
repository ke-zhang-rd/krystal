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

``@`` is a syntax sugar. Under the hood, it is: 

.. code:: python
  
  foo = dec(foo)

  >>> foo()

.. attention::

  This syntax sugar assignment is executed during decorated function definition not on function call.

Decorator doesn't change function name, ``foo`` is still ``foo``. So the thing below ``@dec`` is the input of decorator. In above example, it accepts a **func** and return a **new func**. Decorator also accept arguments.

.. code:: python
  
  @dec(param=something)
  def func(...):
    ...
  
  >>> func()

It could be translated to:

.. code:: python

  true_dec = dec(param=something)
  func = true_dec(func)

  >>> func()

It reveals the logic under the hood is calculating function call ``dec(a=something)`` first which returns the new decorator for later process.

Chained decorators
------------------

.. code:: python

  @outside
  @inside
  def func(...):
    ...

Again, this will translate to thing below during ``func()`` definition. Intuitively, the rule is parsing the inside decorator first and then outside.

.. code:: python

  func = outside(inside(func))

Write a decorator
-----------------

When writing a decorator ``dec``, Let's assume: **it accepts a func and returns a func**. So initially, it should looks like:

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

Since we return ``newfunc`` and ``newfunc`` is the function we will use later, this raise two considerations:

1. ``newfunc`` is a wrapper(from the iteral meaning of decorator) of ``func``, so ``func`` usually is called inside ``newfunc``.
2. Keep in mind ``newfunc`` is the function returned at the end. In definition, ``newfunc`` need to pass any arguments it accepts to ``func``. So ``*args`` and ``**kwargs`` should be used.

#1 makes it look like:

.. code:: python

  def dec(func):
      ...
      def newfunc(...):
          ...
          func(...)
          ...
      return newfunc

Address #2:

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

Again, It runs the function with parameters first which return true decorator. So the definition looks like:

.. code:: python

  def dec(param):
    
    # Write a decorator definition inside and return it.

    return newdec

If we put true decorator definition inside, it will looks like. (``...`` might involve using ``param``).

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

Make any callable become a decorator
------------------------------------

Let's go back to the beginning of decorator syntax, ``func = dec(func)``. Here ``dec`` has to be callable, clearly function is callable, so in above example decorator is a *function*/*class* that accepts X and return a new-X. However, pure function is not the only callable thing. When construct a instance, You use *CLASS* in a callable way.

.. code:: python

  class Dec1:
      
      def __init__(self, func):
          print('__init__')
          self.func = func
      
      def __call__(self, *args, **kwargs):
          print('__call__')
          self.func(*args, **kwargs)

  
  @Dec1
  def foo(a, b):
      print('foo', a, b)

  >>> foo(2, 3)
  # __init__
  # __call__
  # foo 2 3

In this example, we implicit have ``foo = Dec1(foo)`` on global level. ``foo`` become a instance of ``Dec1``.

If ``func = dec(func)`` happend inside Class, on the left hand side, ``func`` become a class attribute. When you use func, instead of call ``func()``, you need ``obj.func``. This gives us a chance to sneak true function object inside return value of ``__get__``, aka **non-data descriptor**. This is exactly logic under the hood of ``staticmethod``.

.. code:: python

  class Dec2:
      
      def __init__(self, func):
          print('__init__')
          self.func = func

      def __get__(self, obj, type=None):
          print('__get__')
          return self.func
  
  
  class C:
      
      @Dec2
      def func2(a, b):
          print('func2', a, b)

  >>> obj = C()
  >>> obj.func2(2, 3)

In this example, we implicit have func2 = Dec2(func2) inside class C. func2 is a class attribute in C. And most important func2 is a *non-data descriptor* defined by ``__get__`` method in class ``Dec2``.

When you write a decorator e.g. ``Dec``, ``Dec`` has to be **callable** to achive ``Dec(...)``. But what is returned and how to use returned value is depend on you. If you want, you could have this(btw, ```...``` below isn't emoji, but it kind of reflect correct feeling):

.. code:: python

  def dimensionality_reduction_attack(func):
    return 1

  @dimensionality_reduction_attack
  def very_funcy_function():
    ...

  >>> very_funcy_function
  1

Finally, I put simplest decorator here for comparasion. 

.. code:: python

  def dec3(func):
      print("newfunc")
      def newfunc(*args, **kwargs):
          func(*args, **kwargs)
      return newfunc    
      

  @dec3
  def func3(a, b):
      print('func3', a, b)

  func3(2, 3)
  # newfunc
  # func3 2 3

I hope you already understand the very beginning statement, decorator is nothing more than ``X = dec(X)``.

Crazy code
----------

This is **LEGAL** in Python 3.13:

.. code:: python

  @(lambda call: lambda func: (lambda *args, **kwargs: getattr(func(*args, **kwargs), call)()))('upper')
  def greet():
    return 'hello world'

  >>> greet()
  'HELLO WORLD'
