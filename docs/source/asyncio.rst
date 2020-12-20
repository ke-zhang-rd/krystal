=======
Asyncio
=======

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
