==================================
Buiding Package: What, Why and How
==================================

setuptools
----------


d



Why build python package is hard
--------------------------------

There may be a time in your development career where you need to author a package that extends Python w/ C or C++. In such a case your Python package needs to go through a compilation process, which converts C or C++ to binaries that work for a specific target system. This becomes really tedious when you think about how many flavors and versions of Linux there are. Building a separate binary for Red Hat, SUSE, Ubuntu, etc... Ugh so tiring.


Look build for windows and mac is eaiser by PEP513 https://peps.python.org/pep-0513/









What is source distribution

What is wheel distribution



How does wheel join your packaging distribution


The tar.gz tarball that pip retrieves is a source distribution, or sdist, rather than a wheel. In some ways, a sdist is the opposite of a wheel.



A developer perspective

Create source distribution sdist
$ python setup.py sdist






A user perspective
