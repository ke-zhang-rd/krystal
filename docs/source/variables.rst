=========
Variables
=========

Even this section is called variables. Actually, in python they should be called names or tags.

* In python everything is object.
* We assign an object to a name.

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
