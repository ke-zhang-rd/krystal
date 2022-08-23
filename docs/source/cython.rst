**************************
cython101
**************************

.. warning::
  
  A numpy **float** is a C **double**!

If you are thinking whether you need cython, in most case, you don't need it, there are
several case that cython might be a really good option.

  * You care more about running time instead of engineering time.
  * You have conclude that your engineering logic no matter the language you use do works, optimization is next step.


The architecture of a cython project
====================================

.. code::

  <PROJECT>
    <MODULE>
      include
        .h
      src
        .cpp
      python
        .pyx
        .pxd
      tests
        .py
    setup.py

.. warning::

  Important! Do not name the .pyx file the same as your .cpp file! When the cythonize function is
  called later, a new .cpp file with the same name as your .pyx file is generated. If you name both
  your original .cpp and your .pyx file the same, your .cpp file will be overwritten! Which is bad.
  
  Though there is tldr `solution <https://cython.readthedocs.io/en/latest/src/userguide/external_C_code.html#resolving-naming-conflicts-c-name-specifications>`_.

Stay with .h and .cpp file
--------------------------
The.h files under *include* and .cpp files under *src* are just pure/raw c++ files. They should be 100% legal in a pure c++ environment.






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
  
  .. code::
  
    def __cinit__(self, int x0, int y0, int x1, int y1):
      self.c_rect = Rectangle(x0, y0, x1, y1)

Next, you just need to rewrite all method you need by calling c object methods, like
  
  .. code::
  
    def get_area(self):
      return self.c_rect.getArea()
      
.pxd file
---------
* Here we are basiclly write Cython code(Cython extension type) as a wrapper to wrap the logic of .h file.
* The role of .pxd file is like a shared header file of cython code for convinent of writing .pyx file.

Use c++ file as source

.. code::
  
  cdef extern from "Rectangle.cpp":
    pass
    
Note that when you use *cdef extern from*, the path that you specify is relative to the current file,

Declare python/cython class with cdef 

.. code
  cdef extern from "Rectangle.h" namespace "shapes":
    cdef cppclass Rectangle:


Next we declare each method and private members

.. code::

  Rectangle() except +
  Rectangle(int, int, int, int) except +
  int x0, y0, x1, y1
  int getArea()
  void getSize(int* width, int* height)
  void move(int, int)
  
expcept + here is make sure that python will raise the exception of c++ error


setup.py
--------
make sure code below are in setup.py

.. code::

  from distutils.core import setup
  from Cython.Build import cythonize

  setup(
  ...
  ext_modules = cythonize('example_cython.pyx'),
  ...)
  
Install package
===============
Run command below

.. code:: bash
  
  $ python setup.py build_ext --inplace

Use setup.cfg to make things easy
---------------------------------

You could config *setup.cfg* by instruction here
https://docs.python.org/3/distutils/configfile.html

For example, the running code above could be configured by *setup.cfg*

.. code::
  
  [build_ext]
  inplace=1
  
and you could just simply run

.. code:: bash
  
  $ python setup.py build_ext

Practice with C and Python community: Eigne and Numpy
=====================================================

How to get Eigen library
------------------------

How to get numpy package
------------------------


How to get cpp std libray
-------------------------
https://cython.readthedocs.io/en/latest/src/userguide/wrapping_CPlusPlus.html?highlight=Rectangle#standard-library

A code here also work as good examples on how to declare C++ classes.

The code below perfectly show us the logistic to mix Eigen and Numpy with Cython. It trys call a *CalcPointAcceleration* from python which transfers all variables to cpp and use some cpp source code with Eigen do real math calculation and then transfer variables back to Numpy.

.pyx file is in
https://github.com/rbdl/rbdl/blob/master/python/rbdl-wrapper.pyx#L1873

.. code:: python
  
  import numpy as np
  cimport numpy as np
  cimport csvd
  
  ...
  
  def CalcPointAcceleration (Model model,
          np.ndarray[double, ndim=1, mode="c"] q,
          np.ndarray[double, ndim=1, mode="c"] qdot,
          np.ndarray[double, ndim=1, mode="c"] qddot,
          unsigned int body_id,
          np.ndarray[double, ndim=1, mode="c"] body_point_position,
          update_kinematics=True):
      return Vector3dToNumpy (crbdl.CalcPointAcceleration (
              model.thisptr[0],
              NumpyToVectorNd (q),
              NumpyToVectorNd (qdot),
              NumpyToVectorNd (qddot),
              body_id,
              NumpyToVector3d (body_point_position),
              update_kinematics
              ))

If we look close of return line, from inside to outside:

1. Call NumpyToEigen-ish function, here it call `NumpyToVectorNd <https://github.com/rbdl/rbdl/blob/master/python/rbdl-wrapper.pyx#L533>`_
2. Call Actuall function by *crbdl.function* name. This *function* is shown in

  * crbdl.pxd by cdef and cdef extern from "<HEADER.h>" namespace "<NAMESPACE>":
  * .h file
  * .cpp file

3. Call EigenToNumpy-ish function, here it call *Vector2dToNumpy*


.h file
https://github.com/rbdl/rbdl/blob/242bf36fbae13ef2b67414e23844f59f97d24ea1/include/rbdl/Kinematics.h#L270

.. code::
  
  Math::Vector3d CalcPointAcceleration (
      Model &model,
      const Math::VectorNd &Q,
      const Math::VectorNd &QDot,
      const Math::VectorNd &QDDot,
      unsigned int body_id,
      const Math::Vector3d &point_position,
      bool update_kinematics = true
      );
      

.cpp file
https://github.com/rbdl/rbdl/blob/242bf36fbae13ef2b67414e23844f59f97d24ea1/src/Kinematics.cc#L513

.. code::

  Vector3d CalcPointAcceleration (
      Model &model,
      const VectorNd &Q,
      const VectorNd &QDot,
      const VectorNd &QDDot,
      unsigned int body_id,
      const Vector3d &point_position,
      bool update_kinematics) {

.pxd file
https://github.com/rbdl/rbdl/blob/242bf36fbae13ef2b67414e23844f59f97d24ea1/python/crbdl.pxd#L254

.. code::
  
  cdef extern from "<rbdl/Kinematics.h>" namespace "RigidBodyDynamics":
      cdef Vector3d CalcPointAcceleration (Model& model,
        const VectorNd &q,
        const VectorNd &qdot,
        const VectorNd &qddot,
        const unsigned int body_id,
        const Vector3d &body_point_coordinates,
        bool update_kinematics)

When you use cdef
=================
When you need define something that need to be used later in python but its come from cpp(in .h file and .cpp file)


numpy import vs cimport
=======================

how to import or cimport numpy in .pyx file.
https://stackoverflow.com/questions/20268228/cython-cimport-and-import-numpy-as-both-np


Cython: "fatal error: numpy/arrayobject.h: No such file or directory"
=====================================================================
https://stackoverflow.com/a/14657667/10642305


Directive comments
==================

The comments in cython related file are compling directives which do take effect.
Ref:
https://cython.readthedocs.io/en/latest/src/userguide/source_files_and_compilation.html#how-to-set-directives
The directive is prefered to setup in setup.py by this
https://cython.readthedocs.io/en/latest/src/userguide/source_files_and_compilation.html#how-to-set-directives


def vs cdef vs cpdef
====================

cdef is basiclly define a function that only workable inside package. it cannot be used by python directly. If you wanna use it by python directly, aka
do something like below

.. code:: python
  
  from pkg.pyx_module import function_defined_inside_pyx
  function_defined_inside_pyx(...)

The function_defined_inside_pyx has to be defined by *cpdef*.
  
Cannot find Eign/Core
=====================
https://github.com/opencv/opencv/issues/14868

How do I wrap a C class with cython
===================================
https://stackoverflow.com/questions/8933263/how-do-i-wrap-a-c-class-with-cython

rectangle.cpp

.. code::

	#include <iostream>
	#include "rectangle.h"

	namespace shapes {

		// Default constructor
		Rectangle::Rectangle () {}

		// Overloaded constructor
		Rectangle::Rectangle (int x0, int y0, int x1, int y1) {
			this->x0 = x0;
			this->y0 = y0;
			this->x1 = x1;
			this->y1 = y1;
	    data << x0, y0, x1, y1;
	    std::cout << "data:" << std::endl;
	    std::cout << data << std::endl;
		}

		// Destructor
		Rectangle::~Rectangle () {}

		// Return the area of the rectangle
		int Rectangle::getArea () {
			// return (this->x1 - this->x0) * (this->y1 - this->y0);
	    return (data[2] - data[0] ) * (data[3] - data[1]);
		}

		// Get the size of the rectangle.
		// Put the size in the pointer args
		void Rectangle::getSize (int *width, int *height) {
			(*width) = x1 - x0;
			(*height) = y1 - y0;
		}

		// Move the rectangle by dx dy
		void Rectangle::move (int dx, int dy) {
			this->x0 += dx;
			this->y0 += dy;
			this->x1 += dx;
			this->y1 += dy;
		}

	  Vec4f cal(Vec4f d) {
	    Vec4f res;
	    float tmp = (d[0] + d[1] + d[2] + d[3]) / 4.0;
	    res << tmp, tmp, tmp, tmp;
	    return res;
	  }
	}



rectangle.h

.. code::

	#ifndef RECTANGLE_H
	#define RECTANGLE_H

	#include <Eigen/Dense>
	#include "cppTypes.h"

	namespace shapes {
	  class Rectangle {
	    public:
	      int x0, y0, x1, y1;
	      float var;
	      Rectangle();
	      Rectangle(int x0, int y0, int x1, int y1);
	      ~Rectangle();
	      int getArea();
	      void getSize(int* width, int* height);
	      void move(int dx, int dy);
	      float getAverage();
	    private:
	      Vec4<int> data;
	  };
	}

	#endif

rectangle.pxd

.. code::

	cdef extern from "cppTypes.h":
	    cdef cppclass Vec4f:
		Vec4f ()
		int rows()
		int cols()
		float& operator[](int)
		float* data()

	cdef extern from "rectangle.cpp":
	  pass

	# Declare the class with cdef
	cdef extern from "rectangle.h" namespace "shapes":
	  cdef cppclass Rectangle:
	    Rectangle() except +
	    Rectangle(int, int, int, int) except +
	    int x0, y0, x1, y1
	    int getArea()
	    void getSize(int* width, int* height)
	    void move(int, int)

	  cdef Vec4f cal(Vec4f) except +

rect.cpp

.. code::

	# distutils: language = c++

	cimport numpy as np
	from rectangle cimport Rectangle
	cimport rectangle

	# Create a Cython extension type which holds a C++ instance
	# as an attribute and create a bunch of forwarding methods
	# Python extension type.
	cdef class PyRectangle:
	    cdef Rectangle c_rect  # Hold a C++ instance which we're wrapping

	    def __cinit__(self, int x0, int y0, int x1, int y1):
		self.c_rect = Rectangle(x0, y0, x1, y1)

	    def get_area(self):
		return self.c_rect.getArea()

	    def get_size(self):
		cdef int width, height
		self.c_rect.getSize(&width, &height)
		return width, height

	    def move(self, dx, dy):
		self.c_rect.move(dx, dy)


	cdef rectangle.Vec4f NumpyToVector4f(np.ndarray['float', ndim=1, mode="c"] x):
	  cdef rectangle.Vec4f cx
	  for i in range(4):
	    cx[i] = x[i]

	  return cx

	cdef np.ndarray[double] Vector4fToNumpy (rectangle.Vec4f cx):
	    result = np.ndarray ((cx.rows()), dtype="float")
	    for i in range (cx.rows()):
		result[i] = cx[i]

	    return result

	cpdef cal(arr):
	  return Vector4fToNumpy(rectangle.cal(NumpyToVector4f(arr)))

tt.py

.. code:: python

	import rect
	import numpy as np

	x0, y0, x1, y1 = 1, 2, 3, 4
	rect_obj = rect.PyRectangle(x0, y0, x1, y1)
	print(rect_obj.get_area())


	arr = np.array([1.0, 2.0, 3.0, 4.0], dtype='float')
	print(rect.cal(arr))

setup.py

.. code:: python

	import rect
	import numpy as np

	x0, y0, x1, y1 = 1, 2, 3, 4
	rect_obj = rect.PyRectangle(x0, y0, x1, y1)
	print(rect_obj.get_area())


	arr = np.array([1.0, 2.0, 3.0, 4.0], dtype='float')
	print(rect.cal(arr))
	(base) *master ke@krystal:~/cy $ cat setup.py
	from setuptools import setup
	from Cython.Build import cythonize


	# ext_modules = [Extension("rect.pyx", ["rectangle.cpp"], language='c++',)]


	setup(ext_modules=cythonize("rect.pyx"))

setup.cfg

.. code::

	[build_ext]
	inplace=1


