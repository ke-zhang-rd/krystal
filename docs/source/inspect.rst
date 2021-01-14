=======================
Inspect function caller
=======================

You write a function ``func()`` and coorperate with popular package in the way this package subscribe ``func()``. You are curious which function of this package actually call your ``func``. ``inspect`` could help you.

.. code:: python

  # This part happen in popular package. 
  def caller():
    a = 1
    b = a + 1
    func() # This function could be called implicitly.
    c = b + 1
    d = c + 1
  
.. code:: python

  # This is your own function.
  import inspect
  def func():
    # f_back go up one in the stack 
    print(inspect.getsource(inspect.currentframe().f_back))
    # Other part...

When you try this popular package methods.

.. code:: python

  >>> caller()

Output:

.. code:: python

  def caller():
    a = 1
    b = a + 1
    func()
    c = b + 1
    d = c + 1

package
-------

I wrote a package called ``ambush`` to do this. https://github.com/ke-zhang-rd/ambush 
