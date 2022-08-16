==================================
Buiding Package: What, Why and How
==================================

What actually happens when a package has been determined to install
-------------------------------------------------------------------

It goes to pypi server and search if there is any distribution available. There are two types of distribution

* source distribution
* build distribution

source distribution is nothing but a tarball file which has everything included inside. build distribuition is aka wheel/whl file which are usually
platform dependent but faster in performance.





What are wheels
---------------
https://realpython.com/python-wheels/




Why build python package is hard
--------------------------------

There may be a time in your development career where you need to author a package that extends Python w/ C or C++. In such a case your Python package needs to go through a compilation process, which converts C or C++ to binaries that work for a specific target system. This becomes really tedious when you think about how many flavors and versions of Linux there are. Building a separate binary for Red Hat, SUSE, Ubuntu, etc... Ugh so tiring.


Look build for windows and mac is eaiser by PEP513 https://peps.python.org/pep-0513/


How to include c++ files(header, source and libraries)
------------------------------------------------------

Those files should be listed in setup.py, usually in Extension method of setuptools.
*#include <Python.h>* should be added as mentioned here https://docs.python.org/3/c-api/intro.html
However, to maintain the c++ files independent which could still be used in pure c++ enviroment. The *#include <Python.h>*  might be
better to add in a wrapper layer which wrap pure c++ files inside.


WARNING

Note that when using setuptools, you should import it before Cython, otherwise, both might disagree about the class to use here.

Method 1
~~~~~~~~

Use *include_path* of *cythonize* and by using C level API like 

.. code:: python

  include_path = [numpy.get_include()]

Note you need this only if you need cimport numpy

Method 2
~~~~~~~~

Use Extension method of setuptools to get the c++ files including, sources, include_dirs, libraries, and library_dirs.
A general example of all those files config example could be found https://github.com/numpy/numpy/blob/b62c541463a9c7ed011436311ff6df9408db6651/site.cfg.example


  * sources (list[str]) – list of source filenames, relative to the distribution root (where the setup script lives),
    in Unix form (slash-separated) for portability. Source files may be C, C++, SWIG (.i), platform-specific resource
    files, or whatever else is recognized by the “build_ext” command as source for a Python extension.
  
  * include_dirs: This is the header files that customized by yourself. This usually achieved by a method
    *get_include* of your own package. That means you need add this method to your package so that it would
    be easier to get the relative location of set
    A example of numpy is: https://github.com/numpy/numpy/blob/main/numpy/lib/utils.py#L19-L45
    Documentation is: https://numpy.org/devdocs/reference/generated/numpy.get_include.html
  
  * library_dirs (list[str]) – list of directories to search for C/C++ libraries at link time
  
  * libraries (list[str]) – list of library names (not filenames or paths) to link against

How does wheel join your packaging distribution

The tar.gz tarball that pip retrieves is a source distribution, or sdist, rather than a wheel. In some ways, a sdist is the opposite of a wheel.



A developer perspective

Create source distribution sdist
$ python setup.py sdist






A user perspective
