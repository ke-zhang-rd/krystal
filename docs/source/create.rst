=============================
Python Object Create Sequence
=============================

Python is doing a lot of thing secretly. There are some magic methods you may define in your class. Before every other things. Here I want to discuss what actually happen when you define a class and construct a object. Here is an example:

.. code:: python

  class Meta_1(type):
      def __call__(cls, *a, **kw):
          print("entering Meta_1.__call__()")
          rv = super(Meta_1, cls).__call__(*a, **kw)
          print("exiting Meta_1.__call__()")
          return rv

  class Class_1(metaclass=Meta_1):
      def __new__(cls, *a, **kw):
          print("entering Class_1.__new__()")
          rv = super(Class_1, cls).__new__(cls, *a, **kw)
          print("exiting Class_1.__new__()")
          return rv

      def __init__(self, *a, **kw):
          print("executing Class_1.__init__()")
          super(Class_1,self).__init__(*a, **kw)

  >>> a = Class_1()
  entering Meta_1.__call__()
  entering Class_1.__new__()
  exiting Class_1.__new__()
  executing Class_1.__init__()
  exiting Meta_1.__call__()

The ``super`` in ``metaclass`` called ``__call__`` of ``type``. The code below reveals what it actually does:

.. code:: python

  class type: 
      def __call__(cls, *args, **kwarg): 
      # ... a few things could possibly be done to cls here
      # then we call cls.__new__() to get a new object 
      obj = cls.__new__(cls, *args, **kwargs) 
      # ... a few things done to obj here
      # then we call obj.__init__() 
      obj.__init__(*args, **kwargs)
      # ... maybe a few more things done to obj here 
      # then we return obj 
      return obj


A diagram of how instances are constructed:

.. image:: ../images/instance_creation.png

If you prefer, you could check source code `here <https://github.com/python/cpython/blob/63298930fb531ba2bb4f23bc3b915dbf1e17e9e1/Objects/typeobject.c#L978-L1044>`_
https://github.com/python/cpython/blob/63298930fb531ba2bb4f23bc3b915dbf1e17e9e1/Objects/typeobject.c#L978-L1044
