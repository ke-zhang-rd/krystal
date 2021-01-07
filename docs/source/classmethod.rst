======================================
classmethod, staticmethod and property
======================================

``classmethod``, ``staticmethod`` and ``property`` are decorators implemented by the descriptor. 

classmethod
-----------

``classmethod`` is another way to create instances.
Notice the first parameter of function of classmethod decorated is CLASS name(Student here) which passed by python internal logic.

.. code:: python

  class Student:

      def __init__(self, first_name, last_name):
          self.first_name = first_name
          self.last_name = last_name

      @classmethod
      def from_string(cls, name_str):
          print("cls: ", cls)
          first_name, last_name = map(str, name_str.split(' '))
          student = cls(first_name, last_name)
          return student
      
      @classmethod
      def from_json(cls, json_obj):
          # parse json...
          return student

  >>> scott = Student('Scott',  'Robinson')
  >>> scott = Student.from_string('Scott Robinson')
  # cls:  <class '__main__.Student'>


staticmethod
------------

``staticmethod`` is a util function of class but the first argument isn’t self. Notice the function decorated by staticmethodis doesn't need use ``self`` to accept instance.

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

``property`` make function become a attribute. ``property`` make function call become a attribute.

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

