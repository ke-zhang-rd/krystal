=====
Super
=====

The meaningj

.. code-block:: python

    super(type, object-or-type)

The true name of super and super’s argument is:
Lineriz(by mro) inherent architecture from object-or-type then search the class from type(right after type) then call whatever the function after it.

For example, if __mro__ of object-or-type is D -> B -> C -> A -> object and the value of type is B, then super() searches C -> A -> object.

a typical superclass call looks like this, C and self are the default arguments:

