=====
Scope
=====


Python has three scopes: local, closure/nonlocal/outer, global. This section will discuss things below:
Is variables a local, nonlocal or global?

  * If no ``nonlocal`` and ``global`` used, variables defined inside function are local variables.
  * When there is a function defined inside another function, in inner funcitoin, nonlocal varialbes are variables defined in outer function.
  * global variables are variables outside of functions, aka in module level

**Rule**

* You could use a closure variable by using ``nonlocal`` and you could use a global variable by global. If nonlocal or global are used, then **both lookup and store** refer to nonlocal or global. e.g.:

.. code:: none

    nonlocal var
    var    =   var + 1
     ↑          ↑
  nonlocal   nonlocal

In this case, two ``var`` in both sides of “=” are **nonlocal** ``var``.

* If there isn't nonlocal or global used, the way python search variable is in order local, closure/nonlocal/outer, global.

Using local

.. code:: python

  var = "global"
  def outer():
      var = "nonlocal"
      def inner():
          var = "local"
          print(var)
      return inner
  
  >>> outer()()
  local

Using nonlocal

.. code:: python

  var = "global"
  def outer():
      var = "nonlocal"
      def inner():
          # var = "local"
          print(var)
      return inner
  
  >>> outer()()
  nonlocal

Using global

.. code:: python

  var = "global"
  def outer():
      # var = "nonlocal"
      def inner():
          # var = "local"
          print(var)
      return inner
  
  >>> outer()()
  global

How to assgin var to another var which has different scope
----------------------------------------------------------

I want to have a local var in inner instead of using nonlocal var. Question: How to assign a nonlocal ``var`` to local ``var``.

**Solution 1**
Just have some variable name with init “l”, short of local:

.. code:: python

  def outer():
      var = 1
      def inner(var=var):
           var += 1
           return var
      return inner

**Solution 2**
Assignment will automatically create local variables in default argument assignment.

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

The type of three scopes could be check by python -mdis xxx.py

The meaning in disassembly:

  +-------------------+------------+-------------+--------------+
  | Scope             | local      | nonlocal    | global       |
  +===================+============+=============+==============+
  | Disassembly READ  | LOAD_FAST  | LOAD_DEREF  | LOAD_GLOBAL  |
  +-------------------+------------+-------------+--------------+
  | Disassembly STORE | STORE_FAST | STORE_DEREF | STORE_GLOBAL |
  +-------------------+------------+-------------+--------------+

If you find *LOAD_DEREF* in inner function which means using nonlocal variable. You may also find *LOAD_CLOSURE* in def inner(...) line.

You could check closure by:

.. code:: python

  out = outer()
  out.__closure__[0].cell_contents
