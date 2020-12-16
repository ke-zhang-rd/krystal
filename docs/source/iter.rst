====
Iter
====

iter(object, sentinel)

iter() Parameters
-----------------

| The iter() function takes two parameters:
| object - object whose iterator has to be created (can be sets, tuples, etc.)
| sentinel (optional) - special value that is used to represent the end of a sequence

| Return value from iter()
| The iter() function returns an iterator object for the given object.
| If the user-defined object doesn't implement __iter__(), and __next__() or __getitem()__, the TypeError exception is raised.
| If the sentinel parameter is also provided, iter() returns an iterator until the sentinel character isn't found.

Example

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

  print_num = PrintNumber(3)

  print_num_iter = iter(print_num)    # Call __iter__
  print(next(print_num_iter))  # 1      Call __next__
  print(next(print_num_iter))  # 2
  print(next(print_num_iter))  # 3

  # raises StopIteration
  print(next(print_num_iter))

Example: iter() with sentinel parameter

.. code:: python

  with open('mydata.txt') as fp:
      for line in iter(fp.readline, ''):
          processLine(line)

When you run the program, it will open the mydata.txt file in reading mode.
Then, the iter(fp.readline, '') in the for loop calls readline (which reads each line in the text file) until the sentinel character, '' (empty string), is reached.
