=============
Comprehension
=============

List comprehension
------------------

.. code:: python

  >>> [i for i in range(5)}]                           
  [0, 1, 2, 3, 4]

.. tip::
   
   There is a shortcut for constructing a list in :ref:`Construct Iterable <construct-iterable>`.

Nested list comprehension
-------------------------

.. code:: python

  >>> [(i,j) for i in range(5) for j in range(i) ]                           

.. code:: python

  [(1, 0),
   (2, 0),
   (2, 1),
   (3, 0),
   (3, 1),
   (3, 2),
   (4, 0),
   (4, 1),
   (4, 2),
   (4, 3)]


.. code:: python

  >>> [j for i in range(5) for j in range(i)]                                

.. code:: python

  [0, 0, 1, 0, 1, 2, 0, 1, 2, 3]

Key point to remember here (which took me a long time to realize) is that the order of the for statements are to be written in the order you'd expect them to be written in a standard for-loop, from the outside inwards.


Dict comprehension
------------------

.. code:: python

  >>> ls = [1,2,3]
  >>> d = {i: i+1 for i in ls}
  >>> d
  {1: 2, 2: 3, 3: 4}

Set comprehension
-----------------

.. code:: python

  >>> ls = [1, 2, 2, 3]
  >>> s = {i for i in ls}
  >>> s
  {1, 2, 3}

Generator comprehension
-----------------------

.. code:: python

  >>> ls = [1, 2, 2, 3]
  >>> s = (i for i in ls)
  >>> list(s)
  [1, 2, 3]

