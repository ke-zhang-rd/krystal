=======
Asyncio
=======

When you use asyncio
--------------------

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

In code above, worker is a **coroutine**. A **coroutine** is a function that can suspend its execution before reaching return, and it can indirectly pass control to another coroutine for some time. My understanding of **corountine** is function defined by ``async`` and use ``await`` inside.

The keyword ``await`` passes function control back to the event loop. (It suspends the execution of the surrounding coroutine. In above example, ``await`` suspends ``worker`` until ``asyncio.sleep(1)`` returned. In the meantime, go let something else run.

.. code:: python
  
  awaitable asyncio.gather(*aws, loop=None, return_exceptions=False)

* Run awaitable objects in the ``aws`` sequence concurrently.
* If any awaitable in ``aws`` is a coroutine, it is automatically scheduled as a Task.
* If all awaitables are completed successfully, the result is an aggregate **list** of returned values. The order of result values corresponds to the order of awaitables in ``aws``.

Design Pattern
--------------
