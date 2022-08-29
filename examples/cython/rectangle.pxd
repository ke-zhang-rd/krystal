cdef extern from "cppTypes.h":
    cdef cppclass Vec4d:
        Vec4f ()
        int rows()
        int cols()
        double& operator[](int)
        double* data()


cdef extern from "rectangle.h" namespace "optimization":
  
    cdef Vec4d ccal(Vec4d) except +
    cdef int var

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

    cdef Vec4d ccal(Vec4d) except +
    cdef int var
