========
for else
========

for/else clause could be useful when you go through iterable for searching purpose.

* If ``break`` isn't called inside ``for`` loop, ``else`` caluse will be execute.
* If ``break`` is called inside ``for`` loop, skip ``else`` clause.

**Example:**

.. code:: python

  ls = [1, 2, 3]

  for i in ls:
    print(i)
  else:
    print("Excute else")

  # Output:
  1
  2
  3
  Excute else

**Example:**

.. code:: python

  for i in ls:
    print(i)
    if i == 3:
      print("Execute break")
      break
  else:
    print("Excute else")

  # Output:
  1
  2
  3
  Execute break
