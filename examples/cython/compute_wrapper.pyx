# distutils: language = c++

cimport numpy as np
from compute_interface cimport Rectangle
from compute_interface cimport Vec4d, Vec4f
from compute_interface cimport ccompute_d, ccompute_f
# rectangle is the name of .pxd from rectangle.pxd
# Rectangle is the class name defined by cdef in rectangle.pxd 


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


cdef Vec4d NumpyToVector4d(np.ndarray['double', ndim=1, mode="c"] x):
  cdef Vec4d cx
  for i in range(4):
    cx[i] = x[i]

  return cx

cdef np.ndarray[double] Vector4dToNumpy (Vec4d cx):
    result = np.ndarray ((cx.rows()), dtype='double')
    for i in range (cx.rows()):
        result[i] = cx[i]

    return result

cpdef compute_d(arr):
    return Vector4dToNumpy(ccompute_d(NumpyToVector4d(arr)))

cdef Vec4f NumpyToVector4f(np.ndarray['float', ndim=1, mode="c"] x):
  cdef Vec4f cx
  for i in range(4):
    cx[i] = x[i]

  return cx

cdef np.ndarray[float] Vector4fToNumpy (Vec4f cx):
    result = np.ndarray ((cx.rows()), dtype='float')
    for i in range (cx.rows()):
        result[i] = cx[i]

    return result

cpdef compute_f(arr):
    return Vector4fToNumpy(ccompute_f(NumpyToVector4f(arr)))
