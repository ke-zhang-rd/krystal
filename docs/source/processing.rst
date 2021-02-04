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

join() and daemon

If in your main process, you call:
  ``p.join()`` make main process wait ``p`` finished.
  ``p.daemon = True``: if main process is closed, also go to close daemoned subprocess ``p``. 

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

.. code:: python

  from multiprocessing import Process, Queue

  def f(q):
      q.put([42, None, 'hello'])

  if __name__ == '__main__':
      q = Queue()
      p = Process(target=f, args=(q,))
      p.start()
      print(q.get())    # prints "[42, None, 'hello']"
      p.join()


Pipe
^^^^

.. code:: python

  out, in = Pipe()

You could think ``out`` and ``in`` as two physical location in memory. You build a bridge between them. So if there is a copy ``out_cp`` and ``in_cp``, you still could use ``in.send()`` and get by ``out_cp.rec()``.

Here is a example:

.. code:: python

  from multiprocessing import Process, Pipe
  import time

  def reader_proc(pipe):
      ## Read from the pipe; this will be spawned as a separate Process
      p_output, p_input = pipe
      p_input.close()    # We are only reading
      while True:
          msg = p_output.recv()    # Read from the output pipe and do nothing
          if msg=='DONE':
              break

  def writer(count, p_input):
      for ii in range(0, count):
          p_input.send(ii)             # Write 'count' numbers into the input pipe
      p_input.send('DONE')

  if __name__=='__main__':
      for count in [10**4, 10**5, 10**6]:
          # Pipes are unidirectional with two endpoints:  p_input ------> p_output
          p_output, p_input = Pipe()  # writer() writes to p_input from _this_ process
          reader_p = Process(target=reader_proc, args=((p_output, p_input),))
          reader_p.daemon = True
          reader_p.start()     # Launch the reader process

          p_output.close()       # We no longer need this part of the Pipe()
          _start = time.time()
          writer(count, p_input) # Send a lot of stuff to reader_proc()
          p_input.close()
          reader_p.join()
          print("Sending {0} numbers to Pipe() took {1} seconds".format(count,
              (time.time() - _start)))

In this example, we put pipe as args while construct Process. You may notice p_output is closed by main process but in ``reader_proc``, p_output.recv() is called. If we print the id of those two ``p_output``, you will find they are different. However, p_input in ``writer`` still could send to a copied ``p_output``. 
Put pipe as args of Process will make subprocess have a builtin communication bridge. It's pretty common to see pipe or one end appearing in args of Process.
The object sent must be picklable. Very large pickles (approximately 32 MiB+, though it depends on the OS) may raise a ValueError exception.

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
