**************************
cython101
**************************


If you are thinking whether you need cython, in most case, you don't need it, there are
several case that cython might be a really good option.

  * You really care about running time instead of engineering time.
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
  
install package
===============
Run command below
.. code:: bash
  
  $ python setup.py build_ext --inplace

Practice with C and Python community: Eigne and Numpy
=====================================================

How to get Eigen library
------------------------

How to get numpy package
------------------------


How to get Cpp std libray
-------------------------
https://cython.readthedocs.io/en/latest/src/userguide/wrapping_CPlusPlus.html?highlight=Rectangle#standard-library





The code below perfectly show us the logistic to mix Eigen and Numpy with Cython.

.pyx file
https://github.com/rbdl/rbdl/blob/master/python/rbdl-wrapper.pyx#L1331

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


1. Call NumpyToEigen-ish function
2. Call Actuall function by cSomething.function name. This function is shown in

  * cSomething.pxd by cdef and cdef extern from "<HEADER.h>" namespace "<NAMESPACE>":
  
  * .h file
  
  * .cpp file

3. Call EigenToNumpy-ish function


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

The function_defined_inside_pyx has to be defined by cpdef.
  
Cannot find Eign/Core
=====================
https://github.com/opencv/opencv/issues/14868

How do I wrap a C class with cython
===================================
https://stackoverflow.com/questions/8933263/how-do-i-wrap-a-c-class-with-cython


.. warning::

  Important! Do not name the .pyx file the same as your .cpp file! When the cythonize function is
  called later, a new .cpp file with the same name as your .pyx file is generated. If you name both
  your original .cpp and your .pyx file the same, your .cpp file will be overwritten! Which is bad.
