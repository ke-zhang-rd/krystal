=====================
Typing and annotation
=====================

Any variable could be annotated by ``:`` operator like:
  
.. code:: python
 
  # Original
  var = value

  # Annotation
  var: TYPE = value

Function
--------
  
.. code:: python
  
  def foo(a, b, c=False, d = None):
      ...

will become
  
.. code:: python
  
  def foo(a: int, b: str, c: bool = False, d: None = None) -> str:
      ...

.. note::

   When we use default value without annotation in function, **no space** around ``=`` is recommended. However, it is recommended when you use annotation. Check `PEP8 <https://www.python.org/dev/peps/pep-0008/#other-recommendations>`_ and `PEP3107 <https://www.python.org/dev/peps/pep-3107/#syntax>`_.
  
Class
-----
  
.. code:: python
  
  class C:
      id
      counter

will become
  
.. code:: python
  
  class C:
      id: int                     
      name: str = 'Picard'
