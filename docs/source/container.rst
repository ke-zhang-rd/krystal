==========================
High performance container 
==========================

counter
-------

queue
-----

PriorityQueue
^^^^^^^^^^^^^

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

Class based API of PriorityQueue

.. code:: python

  from queue import PriorityQueue
  q = PriorityQueue()

  q.put((2, 'code'))
  q.put((1, 'eat'))
  q.put((3, 'sleep'))

  while not q.empty():
      next_item = q.get()
      print(next_item)

  # Result:
  #   (1, 'eat')
  #   (2, 'code')
  #   (3, 'sleep')

Function based API of heapq
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: python

  import heapq
  q = []

  heapq.heappush(q, (2, 'code'))
  heapq.heappush(q, (1, 'eat'))
  heapq.heappush(q, (3, 'sleep'))

  while q:
      next_item = heapq.heappop(q)
      print(next_item)

  # Result:
  #   (1, 'eat')
  #   (2, 'code')
  #   (3, 'sleep')

Class based API of Queue
^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: python

  from queue import Queue

  q = Queue()

  q.put((2, 'code'))
  q.put((1, 'eat'))
  q.put((3, 'sleep'))

  while not q.empty():
      next_item = q.get()
      print(next_item)

  # Result:
  #   (2, 'code')
  #   (1, 'eat')
  #   (3, 'sleep')

deque
-----
