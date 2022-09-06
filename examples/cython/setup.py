from setuptools import setup, Extension

from Cython.Build import cythonize
import numpy

setup(
    ext_modules=cythonize(Extension(name="compute_wrapper",
                                    sources=["compute_wrapper.pyx",
                                             "compute.cpp"],
                                    # Either put .cpp sources file here
                                    # OR by using directive in .pyx file,
                                    #       # directive: sources = compute.cpp
                                    #
                                    # OR by putting code inside .pxd file
                                    #       cdef extern from "compute.cpp":
                                    #           pass
                                    #
                                    include_dirs=[numpy.get_include()],
                                    language="c++",
                                    extra_compile_args=["-std=c++11"],
                                    define_macros=[("NPY_NO_DEPRECATED_API",
                                                    "NPY_1_7_API_VERSION")]
                                    ),
                          compiler_directives={'language_level': '3str'}
                          # This is for eliminate warning, though it is not
                          # very necessary.
                          # FutureWarning: Cython directive 'language_level'
                          # not set, using '3str' for now (Py3). This has
                          # changed from earlier releases!
                          )
)
