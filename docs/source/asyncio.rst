=======
asyncio
=======

What is asyncio
---------------

Async is simply not-sync. Synchronous means in order. So asynchronous menas not in order.
A synchronous programme logic is as simple as function: Enter it, run it then return it. From outside view of function, functions runs one by one. You need wait one finished to start another one. The previous function block running.
Well async allow you run multiple coroutine(name for async function) concurrently.

What is coroutine
-----------------

Just define function by ``async def``. Then we call it a coroutine.

How to run coroutine concurrently
---------------------------------

By using ``asyncio.gather``, coroutines are running concurrently.

A minimum example
-----------------

.. code:: python
  
  import asyncio
  
  async def worker():
    print("One")
    await asyncio.sleep(1)
    print("Two")

  async def main():
    await asyncio.gather(worker(), worker(), worker())

  >>> asyncio.run(main())
  One
  One
  One
  Two
  Two
  Two

| In code above, worker is a **coroutine**. 
| A **coroutine** is a function that can suspend its execution before reaching return, and it can indirectly pass control to another coroutine for some time. My understanding of **corountine** is function defined by ``async`` and use ``await`` inside.

The keyword ``await`` passes function control back to the event loop. (It suspends the execution of the surrounding coroutine. In above example, ``await`` suspends ``worker`` until ``asyncio.sleep(1)`` returned. In the meantime, go let something else run.

.. code:: python
  
  awaitable asyncio.gather(*aws, loop=None, return_exceptions=False)

* Run awaitable objects in the ``aws`` sequence concurrently.
* If any awaitable in ``aws`` is a coroutine, it is automatically scheduled as a Task.
* If all awaitables are completed successfully, the result is an aggregate **list** of returned values. The order of result values corresponds to the order of awaitables in ``aws``.

The reason of concurrently
--------------------------

Why coroutine ran concurrently, there are two concepts, task and future.

Task is a bad name. When coroutine become a task, it actually already start running. This is usually being done by ``create_task``.


Why we need await
-----------------

A example without await

.. code:: python
  
  import asyncio
  import time

  async def say_after(delay, what):
      print(time.time(),'Start say_after(%s, %s)' % (delay,what))
      await asyncio.sleep(delay)
      print(time.time(),what)

  async def main():
      start_time = time.time()
      print(start_time, 'Before creating tasks.')
      task1 = asyncio.create_task(say_after(1, 'hello'))
      task2 = asyncio.create_task(say_after(2, 'world'))
      print(task1)
      print(task1)
      # await task1
      # await task2
      end_time = time.time()
      print('Total time elapsed: %.2f seconds' % (end_time - start_time))

  asyncio.run(main())

Output:

.. code:: none
  
  1612200605.1537979 Before creating tasks.
  <Task pending name='Task-2' coro=<say_after() running at m.py:4>>
  <Task pending name='Task-2' coro=<say_after() running at m.py:4>>
  Total time elapsed: 0.00 seconds
  1612200605.153934 Start say_after(1, hello)
  1612200605.1539571 Start say_after(2, world)









When you use asyncio
--------------------

Solutions choice of CPU bound and IO bound problem.

+----------+--------------------------+-----------------------------------------+---------------+
|          || preemptive multitasking || event driven cooperative multitasking, || multiprocess |
|          || aka multi-threading     || asyncio(single thread, single process) |               |
+==========+==========================+=========================================+===============+
| CPU Bound|not good                  | not good                                | best          |
+----------+--------------------------+-----------------------------------------+---------------+
| IO Bound || Ok if some event refuse | Best                                    | not good      |
|          || to release event loop   |                                         |               |
+----------+--------------------------+-----------------------------------------+---------------+





Design Pattern
--------------

Running Tasks Concurrently

#1

.. code:: python

  async def func()
    await

  async def main():
    asyncio.gather(func)

  asyncio.run(main())


#2
Most important part:
When a coroutine is wrapped into a Task with functions like asyncio.create_task() the coroutine is automatically scheduled to run immediately.
Coroutine start to run immedietely by ``create_task`` and ``await`` make it hand control back to loop.
So ``Task`` is neither a object or a status but a RUNNING stuff. When you create it, it start running immediately.

``await container`` is actually wait. container(a future-like obj) is waiting to be filled. You could use container.result() to check coroutine's return.

.. code:: python

  async def func()
    await

  async def main():
    task1 = asyncio.create_task(func())
    task2 = asyncio.create_task(func())
    await task1
    await task2

  asyncio.run(main())

Notice:

.. code:: python

  import asyncio
  import time

  async def say_after(delay, what):
      await asyncio.sleep(delay)
      print(what)

  async def main():
      print(f"started at {time.strftime('%X')}")

      task1 = asyncio.create_task(say_after(1, 'hello'))
      await task1
      task2 = asyncio.create_task(say_after(2, 'world'))
      await task2

      print(f"finished at {time.strftime('%X')}")

  asyncio.run(main())

Why its need 3 seconds to finish above code:
After ``task1`` by ``create_task``, we are await task1(future-like obj) to be materilized. task2 still not in loop's scope. So even task1 return control back to loop, loop doesn't realize task2. It's actually running in a synchronous way.

Notice:

If a task starts, does it guarantee it ends in expected time? No!


Let’s see this example below.

async def main():
    start_time = time.time()
    print(start_time, 'Before creating tasks.')
    task1 = asyncio.create_task(say_after(1, 'hello'))
    task2 = asyncio.create_task(say_after(2, 'world'))    
    print(time.time(),"Before delay - after creating tasks")
    await asyncio.sleep(0.1)
    time.sleep(3) ##  DELAY ##   
    print(time.time(),"After delay - before await tasks")
    await task1
    await task2
    end_time = time.time()
    print('Total time elapsed: %.2f seconds' % (end_time - start_time))



Here ``loop`` is in the same process with ``time.sleep(3)``. So loop is block for 3 seconds. When loop is resumed, it found task1 and task2(both future-like objs) are already filled, so it immediately continue.

We have asyncio.sleep(0.1) in line #7 to allow task1 and task2 to start, but add time.sleep(3) in line #8 to block for 3 seconds afterwards.
Here is the output:

You see both tasks start immediately in line #3 and #4, but do not ‘say’ after the expected 1 seconds or 2 seconds, instead ‘say’ (end) after 3 seconds.
The reason is that when say_after is awaiting for 1 / 2 seconds, the event loop goes back to main task and blocks there for 3 seconds before it can loop back to say_after tasks to continue.

To achieve good concurrency through coroutines, any code called within asyncio.run must be written in a non-blocking way. In practice, it means that any code run within a task has the responsibility to signal when it is a good time to pause execution, e.g. "I'm not doing anything useful because I'm waiting on I/O..." - this is allowing another task to use the event loop.
