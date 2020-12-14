==================
Starred expression
==================


You may see ``*args``, ``**kwargs`` in many places and was wondering what ``args`` and  ``kwargs`` were.
``args`` is always a iterable and ``kwargs`` is always a dict. 

**Packing uncertain arguments:**

.. code:: python

  def foo(*args, **kwargs):
      print(args)
      print(kwargs)

  t = (3,)
  d = {'a': 1}
  >>> foo(*t, **d)

Here inside foo, ``args`` is a tuple and ``kwargs`` is a dict.
Here when you use a starred expression in a function call, t has to be a iterable and d has to be a dictionary.

**Extract from iterable:**

.. code:: python

  *(a, *b), c = 'this'

This is kind of tricky to find out which is which. It's clear ``c = 's'``.
Then ``a, *b = "thi"``. Then ``a = 't'`` and ``b = "hi"``.

**Construct iterable:**

.. code:: python

  >>> *ls, = range(5)
  >>> ls
  [0, 1, 2, 3, 4]

.. caution::

  The comma ``,`` after ``ls`` is necessary.

