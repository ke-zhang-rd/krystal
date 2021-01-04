====
iter
====

Syntax
------

.. code:: python

  iter(object, sentinel)

Parameters
----------

* *object* - object whose iterator has to be created (can be sets, tuples, etc.)
* *sentinel* (optional) - special value that is used to represent the end of a sequence. If the sentinel parameter is also provided, ``iter`` returns an iterator until the *sentinel* character isn't found.

Return
------

The ``iter`` function returns an iterator object for the given object. If the user-defined *object* doesn't implement ``__iter__``, and ``__next__`` or ``__getitem__``, the TypeError exception is raised. 

.. tip::

  The most **important** thing to remember is ``__iter__`` return a iterable object while ``__next__`` return one element.

**Example: next**

.. code:: python

  class PrintNumber:
      def __init__(self, max):
          self.max = max

      def __iter__(self):
          self.num = 0
          return self

      def __next__(self):
          if(self.num >= self.max):
              raise StopIteration
          self.num += 1
          return self.num

  >>> print_num = PrintNumber(3)
  >>> print_num_iter = iter(print_num) # Call __iter__
  
  >>> print(next(print_num_iter))  # Call __next__
  1
  >>> print(next(print_num_iter))
  2
  >>> print(next(print_num_iter))
  3
  >>> print(next(print_num_iter))
  # raises StopIteration
  # ---------------------------------------------------------------------------
  # StopIteration                             Traceback (most recent call last)

**Example: for loop**

.. code:: python

  print_num = PrintNumber(3)
  for i in print_num:
      print(i)
  
  # Output
  1
  2
  3


  print_num = PrintNumber(3)
  >>> print_num_iter = iter(print_num) # Call __iter__
  for i in print_num:
      print(i)
  
  # Output
  1
  2
  3

**Example: iter() with sentinel parameter**

.. code:: python

  with open('mydata.txt') as fp:
      for line in iter(fp.readline, ''):
          processLine(line)

When you run the program, it will open the mydata.txt file in reading mode.
Then, the iter(fp.readline, '') in the for loop calls readline (which reads each line in the text file) until the sentinel character, '' (empty string), is reached.
