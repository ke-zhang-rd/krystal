=========
dataclass
=========

This module provides a decorator and functions for automatically adding generated special methods such as ``__init__()`` and ``__repr__()`` to user-defined classes.

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

Will add, among other things, a ``__init__()`` that looks like:

.. code:: python

  def __init__(self, name: str, unit_price: float, quantity_on_hand: int=0):
      self.name = name
      self.unit_price = unit_price
      self.quantity_on_hand = quantity_on_hand
