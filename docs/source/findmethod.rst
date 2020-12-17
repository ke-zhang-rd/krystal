===========================
Search methods’s host class
===========================

.. code:: python

  list(cls for cls  in type(obj).mro() if 'target_attribute' in cls.__dict__)

