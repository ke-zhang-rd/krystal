=============================
Chaining Comparison Operators
=============================

Formally, assuming ``a, b, c, …, y, z`` are expressions and ``op1, op2, …, opN`` are comparison operators, then ``a op1 b op2 c ... y opN z`` is equivalent to ``a op1 b and b op2 c and ... y opN z``.

.. code:: python

  >>> x = 5 
  >>> 1 < x < 10 
  True 
  >>> 10 < x < 20 
  False 
  >>> x < 10 < x*10 < 100 
  True 
  >>> 10 > x <= 9 
  True 
  >>> 5 == x > 4 
  True
  >>> i < flag > j


So the expression below is legal.

.. code:: python

  >>> 1 < 2 > 0 < 3 < 4 > 2 < 3
  True

