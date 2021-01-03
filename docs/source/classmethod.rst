======================================
classmethod, staticmethod and property
======================================


Both classmethod and staticmethod are implemented by the descriptor.

* ``classmethod`` is another way to create instances.
* ``staticmethod`` is a util function of class but the first argument isn’t self.
* ``property`` make function become a attribute.

classmethod
-----------

.. code:: python

  class Student:

      def __init__(self, first_name, last_name):
          self.first_name = first_name
          self.last_name = last_name

      @classmethod
      def from_string(cls, name_str):
          first_name, last_name = map(str, name_str.split(' '))
          student = cls(first_name, last_name)
          return student
      
      @classmethod
      def from_json(cls, json_obj):
          # parse json...
          return student

  >>> scott = Student('Scott',  'Robinson')
  >>> scott = Student.from_string('Scott Robinson')

staticmethod
------------

.. code:: python

  class Student(object):

      def __init__(self, first_name, last_name):
          self.first_name = first_name
          self.last_name = last_name

      @staticmethod
      def is_full_name(name_str):
          names = name_str.split(' ')
          return len(names) > 1

  Student.is_full_name('Scott Robinson')   # True
  Student.is_full_name('Scott')            # False

property
--------

.. code:: python

  class Student:

      def __init__(self, first_name, last_name):
          self.first_name = first_name
          self.last_name = last_name
   
      @property
      def name_str(self):
          return self.first_name + self.last_name

  >>> scott = Student('Scott',  'Robinson')
  >>> scott.name_str
