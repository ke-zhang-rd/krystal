=======
Process
=======

Pool
----

Pool is the most common way to in using multiprocessing. Here is a example:

.. code:: python

  from multiprocessing import Pool

  def f(x):
      return x*x

  if __name__ == '__main__':
      with Pool(5) as p:
          print(p.map(f, [1, 2, 3]))

There are several things worth to mention:

* ``Pool()`` return a context manager. This is the most usual way to use ``Pool``. ``__enter__()`` return a Pool object and ``__exit__()`` calls ``terminate()`` method.
* ``Pool()`` uses a method ``map`` to achieve multiprocessing map.
* You need use ``if __name__ == '__main__':`` to protect you main multiprocessings logic. There are more details about this later.

Process
-------

Process is the raw approach to spawn a process.

.. code:: python

  from multiprocessing import Process

  def f(name):
      print('hello', name)

  if __name__ == '__main__':
      p = Process(target=f, args=('bob',))
      p.start()
      p.join()

Clearly, you need use ``start()`` to start a process and ``join()`` make process in which ``join()`` get called wait caller finish, e.g. main process need to wait ``p`` finish here.

Why if __name__ == '__main__':
------------------------------

Python multiprocessing supports two basic ways to start a process: ``spawn`` and ``fork``. Their relationship is sample:

.. code:: python

  spawn = fork + execve

**fork:**

  * The child process, when it begins, is effectively identical to the parent process.
  * All resources of the parent are independent and identical in child process.

**spawn:**

  * Basically, it's rerun code including import module at start of each child process	
  * run ``execve(path)`` which construct a new process based on path. ``path`` is copied pickable process. 
  * So spawn method need lots of things pickable.
  * import module at start of each child process, including ``__main__`` module since you need function ``f`` in your new process. That's the main reason why you need ``if __name__ == '__main__':`` to prevent resursive.
  * Therefore, child process DON'T gets variables defined in name == main block	
  * Extra ``execve`` call make this operation heavy.

.. note::
  
  ``int execve(const char *pathname, char *const argv[], char *const envp[])``

  execve() executes the program referred to by pathname.  This
  causes the program that is currently being run by the calling
  process to be replaced with a new program, with newly initialized
  stack, heap, and (initialized and uninitialized) data segments.


.. Caution::

  Neither method copies running threads into the child processes. So multithreaded process isn't friendly.

Process Communication
---------------------
    
Queue
^^^^^



Pipe
^^^^

.. code:: python

  out, in = Pipe()

You could think ``out`` and ``in`` as two physical location in memory. You build a bridge between them. So if there is a copy ``out_cp`` and ``in_cp``, you still could use ``in.send()`` and get by ``out_cp.rec()``.

Socket
^^^^^^

Sharing state
^^^^^^^^^^^^^

Synchronization
---------------

By Lock

.. code:: python

  from multiprocessing import Process, Lock
  from time import sleep

  def f(l, i):
      l.acquire()
      try:
          print('hello world', i)
          sleep(3)
      finally:
          l.release()

  if __name__ == '__main__':
      lock = Lock()

      for num in range(3):
          p = Process(target=f, args=(lock, num))
          p.start()
          p.join()

This example is basically a serial running one by one. ``p.join()`` make main process with ``p`` finish``.
