========================
deepcopy vs shallow copy
========================

Shallow copy is shallow which means something isn’t copied but changed together. Internal object(object contained in object) will change together.

There is a shallow copy example. ``obj`` will change together in ``obj``, ``var`` and ``var_cp``.

Example:

.. code:: python

    var = [obj, 1, 2, 3]
    var_cp = var[:]

