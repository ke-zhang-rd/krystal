=========
Variables
=========

Even this section is called variables. Actually, in python they should be called names or tags.

* In python everything is object.
* We assign an object to a name:

.. code:: python
  
  a = [1, 2, 3]

* One object could have multiple names. When you assign a name to a new name, the object get a new name(reference).

.. code:: python
  
  b = a

* List, dicts and set are called mutable objects. With mutable object, you could assign its name to a new name(create a reference of object). **AND** you could change object itself(change stuff inside object, e.g. update a element in list). This change could be observed by all names. 

.. code:: python
  
  >>> a[0] = -1
  >>> print(a)
  >>> print(b)
  [-1, 2, 3]
  [-1, 2, 3]
  
* Ints, strings, tuples etc are called immutable objects. With immutable object, you could **ONLY** assign its name to a new name(reference). There isn't anyway to manipulate object itself.

.. code:: python
  
  >>> t = (1,2,3)
  >>> x = t
  >>> print(t)
  >>> print(x)
  (1, 2, 3)
  (1, 2, 3)  


Understanding Python variables and Memory Management
----------------------------------------------------

Have you ever noticed any difference between variables in Python and C? For example, when you do an assignment like the following in C, it actually creates a block of memory space so that it can hold the value for that variable

.. code:: python

  int a = 1;

You can think of it as putting the value assigned in a box with the variable name as shown below.

.. image:: ../images/a1box.png

And for all the variables you create a new box is created with the variable name to hold the value. If you change the value of the variable the box will be updated with the new value. That means doing

.. code:: python

  a = 2;

will result in

.. image:: ../images/a2box.png

Assigning one variable to another makes a copy of the value and put that value in the new box.

.. code:: python

  int b = a;

.. image:: ../images/b2box.png
.. image:: ../images/a2box.png

But in Python variables work more like tags unlike the boxes you have seen before. When you do an assignment in Python, it tags the value with the variable name.

.. code:: python

  a = 1

.. image:: ../images/a1tag.png

and if you change the value of the varaible, it just changes the tag to the new value in memory. You dont need to do the housekeeping job of freeing the memory here. Python's Automatic Garbage Collection does it for you. When a value is without names/tags it is automatically removed from memory.

.. code:: python

  a = 2

.. image:: ../images/a2tag.png

Assigning one variable to another makes a new tag bound to the same value as show below.

.. code:: python

  b = a

.. image:: ../images/ab2tag.png

Other languages have 'variables'. Python has 'names'.
