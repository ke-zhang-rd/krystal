==============
Abstractmethod
==============

When use
--------

When you want to force the subclass that has to have certain methods

How to implement
----------------

* You need to define a abstractclass. Abstract classes are classes that contain one or more abstract methods.
* Class need to be inherint from ABC to make it become a abstracclass
* Decorate with abstractmethod on methods which you want to force subclass has

Example

.. code:: python

  from abc import ABC, abstractmethod
  class AbstractClassExample(ABC):
      
      @abstractmethod
      def do_something(self):
          print("Some implementation!")
          
  class AnotherSubclass(AbstractClassExample):

      def do_something(self):
          super().do_something()
          print("The enrichment from AnotherSubclass")

.. code:: none

  >>> x = AnotherSubclass()
  >>> x.do_something()
  Some implementation!
  The enrichment from AnotherSubclass

About ABC
---------

A helper class that has ABCMeta as its metaclass. With this class, an abstract base class can be created by simply deriving from ABC avoiding sometimes confusing metaclass usage, for example:

.. code:: python

  from abc import ABC
  class MyABC(ABC):
      pass

Note that the type of ABC is still ABCMeta, therefore inheriting from ABC requires the usual precautions regarding metaclass usage, as multiple inheritance may lead to metaclass conflicts. One may also define an abstract base class by passing the metaclass keyword and using ABCMeta directly, for example:

.. code:: python

  from abc import ABCMeta
  class MyABC(metaclass=ABCMeta):
      pass

