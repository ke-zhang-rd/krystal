===============
Walrus operator
===============

The reason why := it's called walrus:

.. image:: ../images/walrus.png
    :width: 400
    :align: center

The academic name of walrus is assignment expression. In computer science, an expression is a syntactic entity in a programming language that may be evaluated to determine its value. So the expression could be treated as a value. ``x := foo()`` has two effects:

  * assign the result of ``foo()`` to ``x``.
  * return the whole expression value which is ``x`` or ``foo()`` (they are equal).

**Example:** if

.. code:: python

    res = foo()
    if res:
        something

could be improved to

.. code:: python
    
    if res := foo():
        something

**Example:** while

.. code:: python

    while True:
        line = fp.readline()
        if not line:
            break     
        something

could be improved to

.. code:: python

    while line := fp.readline():
        something

**Example:** list comprehension

.. code:: python

    results = [(x, f(x), x/f(x)) for x in input_data if f(x) > 0]

could be improved to

.. code:: python

    results = [(x, y, x/y) for x in input_data if (y := f(x)) > 0]

