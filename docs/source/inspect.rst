=======================
Inspect function caller
=======================

You write a function ``func()`` and coorperate with popular package in the way this package subscribe ``func()``. You are curious which function of this package actually call your ``func``. ``inspect`` could help you.

.. code:: python

  import inspect
  
  def caller():
    a = 1
    b = a + 1
    func()
    c = b + 1
    d = c + 1
  
  def func():
    print(inspect.getsource(inspect.currentframe().f_back))
    # f_back go up one in the stack 
  
  >>> caller()

Output:

.. code:: python

  def caller():
    a = 1
    b = a + 1
    func()
    c = b + 1
    d = c + 1
