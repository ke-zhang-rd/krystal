========
for else
========

for else clause could be useful when you go through iterable for searching purpose.

* If ``break`` is called in ``for loop, ``else`` clause won't be execute.
* If ``break`` isn't called in ``for`` loop, ``else`` caluse will be execute.

Example:

.. code:: python

  ls = [1, 2, 3]

  for i in ls:
    print(i)
  else:
    print('in else')

  for i in ls:
    if i == 3:
      break
  else:
    print('in else')
