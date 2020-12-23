=========
itertools
=========

itertools.count
---------------

``count()`` is a infinite loop yield int number from 0

Example:

.. code:: python

  from itertools import count
  for i in count():
      print(i)
  0 
  1
  2
  3
  ...

itertools.chain
---------------

Basically, chain has two method ``chain()`` and ``chain.from_iterable()``
The only difference is their inputs. The argument of chain() is a ``*arg``, seperated by coma, while the ``from_iterable()`` use iterable, like a list. 

Example:

.. code:: python

  from itertools import chain 
  >>> list(chain('abc', 'def'))                                              
  ['a', 'b', 'c', 'd', 'e', 'f']

  >>> list(chain.from_iterable(['abc', 'def']))
  ['a', 'b', 'c', 'd', 'e', 'f']

itertools.compress
------------------

``compress()`` is a data selector, maybe the true name is mask.

Example:

.. code:: python

  >>> list(compress('ABCDEF', [1,0,1,0,1,1]))
  ['A', 'C', 'E', 'F']
