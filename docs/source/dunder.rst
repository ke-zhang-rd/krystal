==============
Dunder methods
==============

__slot__
--------

https://towardsdatascience.com/understand-slots-in-python-e3081ef5196d

__hash__
--------

Called by built-in function hash() and for object comparison. Usually it defined with __eq__ together.

__contains__
__subclasshook__
__format__
__reduce__
__reduce_ex__
__class__
__init_subclass__

__doc__
-------

``obj.__doc__`` show the docstring inside triple quotes ``"""``.

.. code:: python
  # mymodule.py
  """This is the module docstring."""

  def f(x):
      """This is the function docstring."""
      return 2 * x

  
  >>> import mymodule
  >>> mymodule.__doc__
  'This is the module docstring.'
  >>> mymodule.f.__doc__
  'This is the function docstring.'

__str__ and __repr__
--------------------

class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y
    def __repr__(self):
        return f'Point(x={self.x}, y={self.y})'

p = Point(3, 4)
print(p)
Point(x=3, y=4)

class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y
    def __repr__(self):
        return f'Point(x={self.x}, y={self.y})'
    def __str__(self):
        return f'Point(x={self.x}, y={self.y}) from __str__'

p = Point(3, 4)
print(p)
Point(x=3, y=4) from __str__
 
Here __str__ override __repr__.
 
str(p)
'Point(x=3, y=4) from __str__'
 
repr(p)
'Point(x=3, y=4)'
 
print(eval(repr(p)))
Point(x=3, y=4) from __str__
 
eval and repr are conjugate. repr shows the argument’s type info(quote of str).

__setattr__
-----------

>>> # this example uses __setattr__ to dynamically change attribute value to uppercase
>>> class Frob:
...    def __setattr__(self, name, value):
...        self.__dict__[name] = value.upper()
...
>>> f = Frob()
>>> f.bamf = "bamf"
>>> f.bamf
'BAMF'

__getattribute__
----------------

Check lookup chain on this document

__getitem__
-----------

Three dots(Ellipsis)

.. code:: python

  class foo(list):
    def __getitem__(self, arg):
      if arg == ...:
        print('abc')
  
  >>> f = foo()
  >>> f[...]
  abc

__delattr__
-----------

class foo():
    def __delattr__(self, name): 
        print(name)
        super().__delattr__(name)


f = foo()
f.xyz = 123

del f.xyz
f.xyz
AttributeError: 'foo' object has no attribute 'xyz'


__next__ and __iter__
---------------------

* __iter__ return the iterable object(the whole things, list, tuple or generator).
* __next__ return one element.

An iterable object is an object that implements ``__iter__``, which is expected to return an iterator object.
An iterator is an object that implements __next__, which is expected to return the next element of the iterable object that returned it, and raise a StopIteration exception when no more elements are available.
In the simplest case the iterable will implement __next__ itself and return self in __iter__.
 
Example:

.. code:: python

  import random

  class RandomIterable:
      def __iter__(self):
          return self
      def __next__(self):
          if random.choice(["go", "go", "stop"]) == "stop":
              raise StopIteration  # signals "the end"
          return 1
   
Example:

.. code:: python

  def __iter__(self):
      yield 5
      yield from some_list





Comparison methods
------------------

object.__lt__(self, other)
object.__le__(self, other)
object.__eq__(self, other)
object.__ne__(self, other)
object.__gt__(self, other)
object.__ge__(self, other)
