===========================
Search methods’s host class
===========================

If you have a pretty complicated inheritance relationship and you would like to search where your object methods or attributes is defined. Here is a shortcut for this purpose.

.. code:: python

  list(cls for cls in type(obj).mro() if 'target_attribute' in cls.__dict__)

Example:

.. code:: python

  class A:

      def func(self):
          pass


  class B(A):
      pass


  class C(B):
      pass


  >>> c = C()
  >>> c.func()
  >>> print(list(cls for cls in type(c).mro() if 'func' in cls.__dict__))
  # Output
  # [<class '__main__.A'>]
