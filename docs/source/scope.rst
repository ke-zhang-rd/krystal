=====
Scope
=====


Python has three scopes: local, closure/nonlocal/outer, global. This section will discuss things below:
Is variables a local, nonlocal or global?

  * If no ``nonlocal`` and ``global`` used, variables defined inside function are local variables.
  * When discuss in inner funcitoin, nonlocal varialbes are variables defined in outer function.
  * global variables are variables outside of functions.

Rule

* You could use a closure variable by using nonlocal and you could use a global variable by global. If nonlocal or global are used, then both lookup and store refer to nonlocal or global.

.. code:: none

    nonlocal var
    var    =   var + 1
     ↑          ↑
  nonlocal   nonlocal

In this case, two ``var`` in both sides of “=” are **nonlocal** ``var``.

* If there isn't nonlocal or global used, the way python search variable is in order local, closure/nonlocal/outer, global.

.. code:: python

  var = 5
  def outer():
      var = 3
      def inner():
          var = 1
          print(var)
      return inner
  
  >>> outer()()
  1




How to assgin this var to another var which has different scope
---------------------------------------------------------------

I want to have a local var in inner instead of using nonlocal var. How to assign a nonlocal ``var`` to local ``var``.

Assignment will automatically create local variables in default argument assignment.

.. code:: python

  def outer():
      var = 1
      def inner(var=var):
           var += 1
           return var
      return inner

OR people might want to have some variable name with init “l”, short of local:

.. code:: python

  def outer():
      var = 1
      def inner():
           nonlocal var
           lvar = var + 1
           return lvar
      return inner

What tool could be used to check scope
--------------------------------------

The read of three type could be check by python -mdis xxx.py

The meaning in isassembly:

  +-------------------+------------+-------------+--------------+
  | Scope             | local      | nonlocal    | global       |
  +===================+============+=============+==============+
  | Disassembly READ  | LOAD_FAST  | LOAD_DEREF  | LOAD_GLOBAL  |
  +-------------------+------------+-------------+--------------+
  | Disassembly STORE | STORE_FAST | STORE_DEREF | STORE_GLOBAL |
  +-------------------+------------+-------------+--------------+

If you find LOAD_DEREF in inner function. You may find LOAD_CLOSURE for def inner(...) line

You could check by:

.. code:: python

  out = outer()
  out.__closure__[0].cell_contents
