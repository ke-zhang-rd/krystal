==========================
High performance container 
==========================

OrderedDict
-----------

It is a ``dict`` and it has order. It could be constructed by ``dict``.

.. code:: python

  from collections import OrderedDict
  od = OrderedDict({i: j for i, j in zip(['a', 'b','c'], [1,2,3])})
  >>> od
  OrderedDict([('a', 1), ('b', 2), ('c', 3)])

Access by index

.. code:: python

  >>> list(od.items())[0]
  (‘a’, 1)

Change value doesn’t influence order

.. code:: python

  >>> od['a'] = 0
  >>> od
  OrderedDict([('a', 0), ('b', 2), ('c', 3)])

Inserting a new value will beat the end.

.. code:: python

  >>> od['d'] = 4
  >>> od
  OrderedDict([('a', 0), ('b', 2), ('c', 3), ('d', 4)])

queue
-----

**PriorityQueue**

PriorityQueue is a container for min heap.

.. code:: python

  from queue import PriorityQueue
  p = PriorityQueue()
  p.put(3)
  p.put(1)
  p.put(2)

  p.get()
  >>>1

The ``PriorityQueue`` ``get()`` method returns **min** value. To get a maxheap, use put((-value, value))
Here is a conventional pattern for max

.. code:: python

  p.put((-value, value))
  p.put((-3, 3))
  p.put((-1, 1))
  p.put((-2, 2))

  p.get()
  >>> (-2, 2)

Store data with priority number in PriorityQueue

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

**Function based API of heapq**

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

**Class based API of Queue**

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

.. code:: python

  >>> from collections import deque
  >>> d = deque('ghi')                 # make a new deque with three items
  >>> for elem in d:                   # iterate over the deque's elements
  ...     print(elem.upper())
  G
  H
  I

  >>> d.append('j')                    # add a new entry to the right side
  >>> d.appendleft('f')                # add a new entry to the left side
  >>> d                                # show the representation of the deque
  deque(['f', 'g', 'h', 'i', 'j'])

  >>> d.pop()                          # return and remove the rightmost item
  'j'
  >>> d.popleft()                      # return and remove the leftmost item
  'f'
  >>> list(d)                          # list the contents of the deque
  ['g', 'h', 'i']
  >>> d[0]                             # peek at leftmost item
  'g'
  >>> d[-1]                            # peek at rightmost item
  'i'

  >>> list(reversed(d))                # list the contents of a deque in reverse
  ['i', 'h', 'g']
  >>> 'h' in d                         # search the deque
  True
  >>> d.extend('jkl')                  # add multiple elements at once
  >>> d
  deque(['g', 'h', 'i', 'j', 'k', 'l'])
  >>> d.rotate(1)                      # right rotation
  >>> d
  deque(['l', 'g', 'h', 'i', 'j', 'k'])
  >>> d.rotate(-1)                     # left rotation
  >>> d
  deque(['g', 'h', 'i', 'j', 'k', 'l'])

  >>> deque(reversed(d))               # make a new deque in reverse order
  deque(['l', 'k', 'j', 'i', 'h', 'g'])
  >>> d.clear()                        # empty the deque
  >>> d.pop()                          # cannot pop from an empty deque
  Traceback (most recent call last):
      File "<pyshell#6>", line 1, in -toplevel-
          d.pop()
  IndexError: pop from an empty deque

  >>> d.extendleft('abc')              # extendleft() reverses the input order
  >>> d
  deque(['c', 'b', 'a'])
