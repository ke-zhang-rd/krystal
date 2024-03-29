cdef extern from "cppTypes.h":
    cdef cppclass Vec4d:
        Vec4d ()
        int rows()
        int cols()
        double& operator[](int)
        double* data()

cdef extern from "cppTypes.h":
    cdef cppclass Vec4f:
        Vec4f ()
        int rows()
        int cols()
        float& operator[](int)
        float* data()


# cdef extern from "compute.cpp":
#     pass
# Either use code above
# OR set "sources" argument of Extension in setup.py
#
# OR by using directive in .pyx file,
#       # directive: sources = compute.cpp


# Declare the class with cdef
cdef extern from "compute.h" namespace "shapes":
    cdef cppclass Rectangle:
        Rectangle() except +
        Rectangle(int, int, int, int) except +
        int x0, y0, x1, y1
        int getArea()
        void getSize(int* width, int* height)
        void move(int, int)


cdef extern from "compute.h" namespace "optimization":
  
    cdef Vec4d ccompute_d(Vec4d) except +
    cdef Vec4f ccompute_f(Vec4f) except +
