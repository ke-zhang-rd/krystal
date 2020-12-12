========
for else
========

.. ipython::

  In [1]: ls = [1, 2, 3]

  In [2]: for i in ls:
     ...:     print(i)
     ...: else:
     ...:     print('in else')


  In [3]: for i in ls:
     ...:     if i == 3:
     ...:         break
     ...: else:
     ...:     print('in else')
