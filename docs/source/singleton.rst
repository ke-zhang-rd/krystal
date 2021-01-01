=========
Singleton
=========

Singleton implementation
------------------------

.. code-block:: python

    import random
    class Singleton(type):
        _instances = {}
        def __call__(cls, *args, **kwargs):
            print('enter Singleton call')
            if cls not in cls._instances:
                cls._instances[cls] = super(Singleton, cls).__call__(*args, **kwargs)
            print('exit Singleton call')
            return cls._instances[cls]

    class Baseclass:
        def __new__(cls, *args, **kwargs):
            print('Base new')
            return super().__new__(cls, *args, **kwargs)

        def __init__(self, *args, **kwargs):
            print('Base init')
            super().__init__(*args, **kwargs)
        
    class Foo(Baseclass, metaclass=Singleton):
        def __new__(cls, *args, **kwargs):
            print('Foo new')
            return super().__new__(cls, *args, **kwargs)

        def __init__(self, *args, **kwargs):
            print('Foo init')
            self.value = random.randint(0,10)
            super().__init__(*args, **kwargs)

    a = Foo()

.. code-block:: python

    enter Singleton call
    Foo new
    Base new
    Foo init
    Base init
    exit Singleton call

.. note::

    * The order of function call is deeply embedded in type’s call mentioned in section Python create sequence of this document and also in this C code.
    * The ``*args`` and ``**kwargs`` of Foo's ``__new__`` will unchangely pass to Foo’s ``__init__`` implicitly.
    * ``_instances = {}`` instead of ``_instances = None`` make Singleton available for multiple classes instead only one. Therefore, you could have Foo(metaclass=Singleton), Bar(metaclass=Singleton) … instead of only one.


Another Singleton implementation by using ``__new__`` case and why it’s not work

.. code:: python

  import random
  class Singleton:
      _ins = None
      def __new__(cls, tmp, *args, **kwargs):
          if not cls._ins:
              cls._ins = super().__new__(cls,*args)
              return cls._ins
          else:
              return cls._ins

  class Foo(Singleton):
      def __init__(self):
          self.value = random.randint(0,10)

.. code:: python

  a = Foo()
  print(a.value)
  b = Foo()
  print(a is b)
  print(b.value)

Output:

.. code:: python

  0
  True
  4

The reason is ``__new__`` and ``__init__`` are two seperated channels. Consult the diagram in :ref:`Object Create Sequence <object-create-sequence>`

So the ``__init__`` of ``Foo`` is executed no mattar what ``__new__`` of ``Singleton`` returned. This make ``value`` reassigned. 

The approach to avoid ``__init__`` get called is finding where the ``__init__`` is executed and try to avoid it. Obviously, the logic of ``__init__`` is embedded in ``__call__`` of metaclass, ``type`` in this case, as shown in :ref:`Object Create Sequence <object-create-sequence>`. So eventually, we need a new metaclass and a different logic of ``__call__`` implementation. The new logic return the cached instance if there is an instance cached in ``_instances``and avoid calling ``__new__`` and ``__init__`` totally. This is exactly what we do in correct implementation as shown in beginning part of this section. 
