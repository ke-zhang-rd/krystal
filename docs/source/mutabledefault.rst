=========================
Mutable default arguments
=========================

Python is so duck-typing. However, mutable default arguments of function call isn't one of them. Here is an example:

.. code:: python

  def compute(inputs: list=[]):
      inputs.append("something")
      patterns = ["a list based on"] + inputs
      return patterns

**MISUNDERSTANDING:** Function call are always idempotent. ``inputs`` will be initialized to an empty list when lacking parameters. **Illusion** of this function call:

.. code:: python

  >>> compute()
  ["a list based on", "something"]

  >>> compute() 
  ["a list based on", "something"] #Illusion, Not the reality
  
Reality:

.. code:: python

  >>> compute()
  ["a list based on", "something"]

  >>> compute()
  ["a list based on", "something", "something"]

There 2 things under the hood.

  1. Default variable is an attribute of the function object. Yes, your function is just an object and your default variable is an attribute of that object. It's an attribute of the object for all function calls. 
  2. Assignment always creates a new local variable in the innermost scope. Consult `this <https://stackoverflow.com/a/1133375/10642305>`_ for more.

There are two types of local variables: function default attribute and function call’s new local by assignment. Both variables(function attribute and variable of function call are both local). It doesn’t involve closure. 

.. code:: python

  def func(foo=[]):
    if foo == [] or foo == [1]:
      print(id(foo))
      foo.append(1)
      foo = []
      print(id(foo))
    print(func.__defaults__)
    print(locals())
    print(foo)
    return foo

  func()
  print()
  func()
  print()
  func()

Output

.. code:: python

  140674899168960
  140674899568704
  ([1],)
  {'foo': []}
  []

  140674899168960
  140674899568704
  ([1, 1],)
  {'foo': []}
  []

  ([1, 1],)
  {'foo': [1, 1]}
  [1, 1]

.. important::

  ``foo = []`` assignment will create a new variable instead of changing default ``foo``.
  ``if foo == [] or foo == [1]:`` is checking default argument foo’s value.
  But ``foo = []`` created a new local foo variable.
