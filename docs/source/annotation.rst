=====================
Typing and annotation
=====================

Clearly, any ``var`` could be annotated by ``:`` operator like:
  
.. code:: python
  
  var = value
  var: str = value

Function
--------
  
.. code:: python
  
  def foo(a, b, c=False, d = None):
      ...

will become
  
.. code:: python
  
  def foo(a: int, b: str, c: bool = False, d: None = None) -> str:
      ...

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
      counter: ClassVar[int] = 0 
