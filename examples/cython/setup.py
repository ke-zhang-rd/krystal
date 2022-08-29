from setuptools import setup, Extension

from Cython.Build import cythonize
import numpy

setup(
    ext_modules=cythonize(Extension(name="compute_wrapper",
                                    sources=["compute_wrapper.pyx"],
                                    include_dirs=[numpy.get_include()],
                                    language="c++",
                                    extra_compile_args=["-std=c++11"],
                                    define_macros=[("NPY_NO_DEPRECATED_API",
                                                    "NPY_1_7_API_VERSION")]
                          )
                )
)
