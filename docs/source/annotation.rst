=====================
Typing and annotation
=====================

Clearly any ``var`` could be annotated by ``:`` operator like
  
.. code:: python
  
  var = value
  var: str = value

So in a function, this means
  
.. code:: python
  
  def foo(a, b, c=False, d = None):
      ...

will become
  
.. code:: python
  
  def foo(a: int, b: str, c: bool = False, d: None = None) -> str:
      ...

Class annotation
  
.. code:: python
  
  class C:
      id: int                     
      counter: ClassVar[int] = 0 

