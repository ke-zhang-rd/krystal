=====================
Case Study: dataclass
=====================

``dataclass`` provides a decorator and functions for automatically adding generated special methods such as ``__init__()`` and ``__repr__()`` to user-defined classes.

**Example:**

.. code:: python

  from dataclasses import dataclass

  @dataclass
  class InventoryItem:
      """Class for keeping track of an item in inventory."""
      name: str
      unit_price: float
      quantity_on_hand: int = 0

      def total_cost(self) -> float:
          return self.unit_price * self.quantity_on_hand

``dataclass`` also accept optional parameters, these three uses of ``dataclass`` are equivalent:

.. code:: python

  @dataclass
  class C:
      ...

  @dataclass()
  class C:
      ...

  @dataclass(init=True, repr=True, eq=True, order=False, unsafe_hash=False, frozen=False)
  class C:
     ...

It will add, among other things, a ``__init__()`` that looks like:

.. code:: python

  def __init__(self, name: str, unit_price: float, quantity_on_hand: int=0):
      self.name = name
      self.unit_price = unit_price
      self.quantity_on_hand = quantity_on_hand

a nice print out powered by ``__repr__``:

.. code:: python

  InventoryItem(name='widget', unit_price=3.0, quantity_on_hand=10)

So, how does ``dataclass`` make parens optional. Below are source code of dataclass from `cpython <https://github.com/python/cpython/blob/master/Lib/dataclasses.py#L1015>`_

.. code:: python

  def _process_class(cls, init, repr, eq, order, unsafe_hash, frozen):
      # Some cls modification by parameters.
      ... 
      return cls

  def dataclass(cls=None, /, *, init=True, repr=True, eq=True, order=False,
                unsafe_hash=False, frozen=False):
      """Returns the same class as was passed in, with dunder methods
      added based on the fields defined in the class.
      Examines PEP 526 __annotations__ to determine fields.
      If init is true, an __init__() method is added to the class. If
      repr is true, a __repr__() method is added. If order is true, rich
      comparison dunder methods are added. If unsafe_hash is true, a
      __hash__() method function is added. If frozen is true, fields may
      not be assigned to after instance creation.
      """

      def wrap(cls):
          return _process_class(cls, init, repr, eq, order, unsafe_hash, frozen)

      # See if we're being called as @dataclass or @dataclass().
      if cls is None:
          # We're called with parens.
          return wrap

      # We're called as @dataclass without parens.
      return wrap(cls)

Of course, the interesting part is conditional part. If ``cls is None`` means this case come with parameters and parens. So we need to return a true decorator configured by parameters. And parameters is reflected by closure. ``_process_class`` is function actually return the new cls. If ``cls`` is not ``None``, ideally this means no parameters and parens are used. we just need call wrap(cls) which return a new cls.

However, this implementation doesn't block user use a position parameter fail decorator as shown below:

.. code:: python

  @dataclass(1) # cls is 1 here
  class C:
    pass

