==========================
High performance container 
==========================

counter
-------

PriorityQueue
-------------

PriorityQueue is a good container for min heap.

.. code:: python

  from queue import PriorityQueue
  p = PriorityQueue()
  p.put(3)
  p.put(1)
  p.put(2)

  p.get()
  >>>1

The priorityqueue get() method returns min value. To get a maxheap, use put((priority, value))
Here is a conventional pattern for max

.. code:: python

  p.put((-value, value))
  p.put((-3, 3))
  p.put((-1, 1))
  p.put((-2, 2))

  p.get()
  >>> (-2, 2)

deque
-----
