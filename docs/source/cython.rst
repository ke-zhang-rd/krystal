=========
cython101
=========

The reason why you need cython. In my practice, in most case, you don't need it, there are several case that
cython might be a really good option.


You really care about running time instead of engineering time.

You have conclude that your faster engineering logic works, optimization is next step.


The architecture of cython orgnization
--------------------------------------

<PROJECT>
  <MODULE>
    include
      .h
    src
      .cpp
    python
      .pxd
      .pyx
    tests
      .py
  setup.py


Stay with .h and .cpp file
--------------------------
.h and .cpp files are just pure/raw c++ files. They should be 100% legal in a pure c++ environment.

  
construct .pxd file
-------------------
Here we are basiclly write python code(Cython extension type) as a wrapper to wrap the logic of .h file.


Use c++ file as source
.. code::
  
  cdef extern from "Rectangle.cpp":
    pass
    
Note that when you use cdef extern from, the path that you specify is relative to the current file,

Declare python/cython class with cdef 

.. code
  cdef extern from "Rectangle.h" namespace "shapes":
    cdef cppclass Rectangle:


Next we declare each method and private members

.. code

  Rectangle() except +
  Rectangle(int, int, int, int) except +
  int x0, y0, x1, y1
  int getArea()
  void getSize(int* width, int* height)
  void move(int, int)
  
expcept + here is make sure that python will raise the exception of c++ error




construct .pyx file
-------------------

Here we are basiclly write python code(Cython extension type) as a wrapper to wrap the logic of .cpp file.

In my naive understanding, this file contain rewritten python-ish code that matches your function and class
in c++ files. 
We write it in rect.pyx here while there is convention that is called xxx-wrapper.pyx.

At the beginning, you need cimport your c class definition(It represent cpp class in a python/cython class way)
from pxd module. If you have 'Rectangle.pxd', then

.. code
  from Rectangle cimport Rectangle

In the python class that we are about to write, you need use cdef to define a python-ish class for latter use.

.. code

  cdef class Pyrectangle:

which has a c object as an attribute

  * declare it by c class which was cimport just above. This declaration usually take place in class attribute
  location.
  
  .. code
      cdef Rectangle c_rect
  
  * In __cinit__ magic method, construct c object as a attribute of python class.
  .. code
  
    def __cinit__(self, int x0, int y0, int x1, int y1):
      self.c_rect = Rectangle(x0, y0, x1, y1)

Next, you just need to rewrite all method you need by calling c object methods, like
  
  .. code
    def get_area(self):
      return self.c_rect.getArea()
      
      
setup.py
--------
make sure code below are in setup.py

.. code
  from distutils.core import setup
  from Cython.Build import cythonize

  setup(ext_modules = cythonize('example_cython.pyx'))
  
install package
---------------
.. code
  $ python setup.py build_ext --inplace
