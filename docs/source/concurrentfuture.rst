=====================================
Processing async vs concurrent.future
=====================================

Usually, processing are Synchronizing and you could only get all result after all of them finished. What if you want to get each value once it finished. Basically, there are two approcaches and they all involve a concept Future.

If you dont' understand what is Future, check Future section of this tutorial.


Examples:

Diff1: Both have callback mechanisms:
-------------------------------------

.. code:: python
  
  from multiprocessing import Pool

  def work_process(i):
    return i * i

  def print_result(i):
    return i

  def main():
    with Pool(4) as pool:
      for i in range(10):
        pool.apply_async(work_process, args=(i,), callback = print_result)

  if __name__ == "__main__":
    main()


.. code:: python

  from concurrent.futures import ProcessPoolExecutor

  def worker_process(i):
    return i * i

  def print_result(future):
    print(future.result())

  def main():
    with ProcessPoolExecutor(4) as ppe:
      futures = [ppe.submit(worker_process, i) for i in range(10)]
      for future in futures:
        future.add_done_callback(process_result)

  if __name__ == "__main__":
    main()

Notice in ``concurrent.futures`` example, you need pass *future* into callback instead of result. 
Diff2: Get result as complete
-----------------------------

You could use ``as_completed`` function, as guarantee to make sure future has been completed, process result as it complete.

.. code:: python

  from concurrent.futures import ProcessPoolExecutor

  def work_process(i):
    return i * i

  def main():
    with ProcessPoolExecutor(4) as ppe:
      futures = [ppe.submit(worker_process, i) for i in range(10)]
        for future in concurrent.futures.as_completed(futures):
          print(future.result())

  if __name__ == '__main__':
    main()

.. code:: python

  import multiprocessing as mp

  def worker_process(i):
      return i * i # square the argument

  def compute_chunksize(pool_size, iterable_size):
      if iterable_size == 0:
          return 0
      chunksize, extra = divmod(iterable_size, pool_size * 4)
      if extra:
          chunksize += 1
      return chunksize

  def main():
      cpu_count = mp.cpu_count()
      N = 100
      chunksize = compute_chunksize(cpu_count, N)
      with mp.Pool() as pool:
          for result in pool.imap_unordered(worker_process, range(N), chunksize=chunksize):
              print(result)

  if __name__ == '__main__':
      main()


Diff3: Get incompleted result
-----------------------------

.. code:: python

  from concurrent.futures import ProcessPoolExecutor, TimeoutError
  from time import sleep


  def worker_1():
      while True:
          print('hanging')
          sleep(1)


  def main():
      with ProcessPoolExecutor(1) as pool:
          future = pool.submit(worker_1)
          try:
              future.result(3) # kill task after 3 seconds?
          except TimeoutError:
              print('timeout')

  if __name__ == '__main__':
      main()
      print("return from main()")

.. code:: python

  from multiprocessing import Pool, TimeoutError
  from time import sleep


  def worker_1():
      while True:
          print('hanging')
          sleep(1)

  def main():
      with Pool(1) as pool:
          result = pool.apply_async(worker_1, args=())
          try:
              result.get(3) # kill task after 3 seconds?
          except TimeoutError:
              print('timeout')


  if __name__ == '__main__':
      main()
      print("return from main()")

This time, however, even though the timed-out task is still continuing to run and is typing up the process, the with block is not prevented from exiting and thus the program terminates normally. The reason for this is that the context manager for the Pool instance will execute a call to terminate when the block exits and this results in the immediate termination of all processes in the pool. This is contrasted with the context handler for the ProcessPoolExecutor instance, which executes a call to shutdown(wait=True) to await the termination of all processes in the pool when the block it governs exits. The advantage would seem to go to multiprocessing.Pool if you are using context handlers to handle pool termination and the possibility of a timeout exists.



Diff4: Block call:
------------------

.. code:: python

  import multiprocessing as mp

  def worker_process(i):
      return i * i # square the argument

  def main():
      with mp.Pool() as pool:
          print(pool.apply(worker_process, args=(6,)))
          print(pool.apply(worker_process, args=(4,)))

  if __name__ == '__main__':
      main()


The multiprocessing.Pool class has a method apply that submits a task to the pool and blocks until the result is ready. The return value is just the return value from the worker function passed to the apply function.
The concurrent.futures.ThreadPoolExecutor class has no such equivalent. You have to issue a submit and then a call to result against the returned Future instance. It's not a hardship to have to do this, but the pool.apply method is more convenient for the use case where a blocking task submission is appropriate.


Diff5: tie the return value back to the original passed argument
----------------------------------------------------------------

.. code:: python

  import concurrent.futures

  def worker_process(i):
      return i * i # square the argument

  def main():
      with concurrent.futures.ProcessPoolExecutor() as executor:
          futures = {executor.submit(worker_process, i): i for i in range(10)}
          for future in concurrent.futures.as_completed(futures):
              i = futures[future] # retrieve the value that was squared
              print(i, future.result())

  if __name__ == '__main__':
      main()

But with multiprocessing, there is no way to easily tie a result with a submitted job unless the worker process returned the original call arguments along with the return value. 
