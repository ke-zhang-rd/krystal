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

**Example:**

.. code-block:: python
  :caption: main.py
  :linenos:

  from sub import Member


  class Primary:

      def foo(self):
          a = 1
          a = a + 1
          m = Member()
          m.bar()
          a = a + 1
          a = a + 1


  p = Primary()
  p.foo()

.. code-block:: python
  :caption: sub.py
  :linenos:

  class Member:


      def bar(self):
          from ambush import detector
          detector()

**Output:**

.. code:: none

  Who is calling current function
  =========================================================
  In file:
  /Users/kz2249/tmp/main.py

  class Primary:
      # by caller function:
      def foo in line 6
          ...
          # actually call:
          m.bar() # in line 10
          ...

  Peek:
  ---------------------------------------------------------
      def foo(self):
          a = 1
          a = a + 1
          m = Member()
          m.bar()
          a = a + 1
          a = a + 1

  =========================================================
