======
walrus
======

The reason why := it's called walrus

.. image:: ../images/walrus.png
    :width: 400
    :align: center

Naming the result of an expression is important. ``x := foo()`` could be desrcibed as naming the result of ``foo()`` as ``x``.

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

