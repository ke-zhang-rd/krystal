=========
Variables
=========

Even this section is called variables. Actually, in python they should be called names or tags.

* In python everything is object.
* We assign an object to a name.
* One object could have multiple names. When you assign a name to a new name, the object get a new name(reference).
* List, dicts and set are called mutable objects.
* Ints, strings, tuples etc are called immutable objects.
* With mutable object, you could change object itself(change thing inside object, e.g. update a lement in list). This change could be observed by all names.
* With mutable object, you could assign its name to a new name(create a reference of object).
* With immutable object, you could only assign its name to a new name(reference). There isn't anyway to manipulate object itself.

**Example:**

.. code:: python
  
  a = [1, 2, 3]
  b = a
  a[0] = -1
  print(a)
  print(b)
  t = (1,2,3)
  x = t
  print(t)
  print(x)

**Output:**

.. code:: python

  [-1, 2, 3]
  [-1, 2, 3]
  (1, 2, 3)
  (1, 2, 3)  
