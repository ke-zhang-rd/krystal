=========
singleton
=========

.. code-block:: python

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
