============
new vs  init
============

* ``__new__`` is the true constructor of class. It need to return a obj.
* ``__init__`` initializ object. It doesn't need to return. 

Think they are two channels one by one called by Cls(). Your arguments will be passed separately to both functions.

* If ``__init__`` lacking, it will run default ``__init__`` which runs its parent ``__init__``. This logic is embedded in ``type``'s ``__call__``. There is more talk in Python Create Sequence section.
* If ``__init__`` is implemented and your class inherits from a base class, conventionally, you may still want to put parents ``__init__`` which by ``super().__init__()`` inside child's ``__init__``. It’s conventional since you may want to invoke initialization of parent ``__init__``. However, if you choose not to include ``super().__init__()``, that’s fine.

This is same for ``__new__``.

Example:

.. code:: python

  class Foo:
      def __new__(cls):
          print('this is Foo __new__')
          print(cls)
          return super().__new__(cls)
      def __init__(self):
          print('this is Foo __init__')


  class foo(Foo):
      def __new__(cls, *args, **kwargs):
          print('this is foo __new__')
          instance = super().__new__(cls, *args, **kwargs)
          instance.attr = 100
          return instance
      def __init__(self):
          print('this is foo __init__')
          super().__init__()

.. code:: python

  >>> f = foo()
  this is foo __new__
  this is Foo __new__
  <class '__main__.foo'>
  this is foo __init__
  this is Foo __init__

.. code:: python

  class Foo:
      def __new__(cls):
          print('this is Foo __new__')
          print(cls)
          return super().__new__(cls)
      def __init__(self):
          print('this is Foo __init__')

  class foo(Foo):
      pass
  
.. code:: python

  >>> f = foo()
  this is Foo __new__
  <class '__main__.foo'>
  this is Foo __init__

