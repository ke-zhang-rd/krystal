============
new vs  init
============

| ``__new__`` is the true constructor of class. It need to return a obj.
| ``__init__`` initializes object. It doesn't need to return anything. 

``__new__`` is a staticmethod: When class wants this magic method it will be looked up on the same object (the class), not on a upper level like all the other magic methods. This is very important to understand, because both the class and the metaclass can define this method


* Think ``__new__`` and ``__init__`` are two channels. ``__new__`` get called first and then ``__init__``. Your arguments are passed separately to both functions except first one. This logic is embedded in ``type``'s ``__call__``. This is same for ``__new__``.

* If ``__init__`` is implemented and your class inherits from a base class, conventionally, you may still want to put parents ``__init__`` which by ``super().__init__()`` inside child's ``__init__``. It’s conventional since you may want to invoke initialization of parent ``__init__``. However, if you choose not to include ``super().__init__()``, that’s fine. This is same for ``__new__``.

Example:

.. code:: python

  class Foo:
      def __new__(cls, *args, **kwargs):
          print('this is Foo __new__')
          print(cls)
          return super().__new__(cls)
      def __init__(self, *args, **kwargs):
          print('this is Foo __init__')


  class foo(Foo):
      def __new__(cls, *args, **kwargs):
          print('this is foo __new__')
          instance = super().__new__(cls, *args, **kwargs)
          instance.attr = 100
          return instance
      def __init__(self, *args, **kwargs):
          print('this is foo __init__')
          super().__init__(*args, **kwargs)

.. code:: python

  >>> f = foo()
  this is foo __new__
  this is Foo __new__
  <class '__main__.foo'>
  this is foo __init__
  this is Foo __init__

* If ``__new__`` get called by **class**(in metaclass's __call__), since it's a staticmethod, it will call class's __new__. This will go to class attribute lookup. In default, it will run ``__new__`` by looking class.__dict__ which includes its parent ``__new__`` if necessary. 
* If ``__init__`` get called by **instance**(in metaclass's __call__), since it's not a staticmethod. it will call upper level __init__ which is defined in class. This will go to instance attribute lookup. In default, it will run ``__init__`` by looking Class.__dict__ which includes parent ``__init__`` if necessary.
.. caution::

  ``Class.__dict__`` is not a real dict but a special dict proxy that will also look in all the base classes.
  For clarity I've simplified things to Class.__dict__['foobar'] but in reality the __dict__ proxy object is not used, but instead all the logic is inlined: attributes are looked up on the class of the object in the order of the __mro__ via typeobject.c:_PyType_Lookup (called from object.c: _PyObject_GenericGetAttrWithDict).

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
