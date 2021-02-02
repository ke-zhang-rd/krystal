Future
======

What is Future...

My future are: go to ivy-league, date with cheerleader, be rich and travel around the world.

Nonono, that's not the future we are talking today.

We are talking future come from investment.

Futures are derivative financial contracts that obligate the parties to transact an asset at a predetermined future date and price.

In short words: Futures are something haven't arrived but will arrive.

The relation ship between coroutine and future.

* coroutine is wrapped into a Task with functions like asyncio.create_task()
  coroutine are function or other flow control keywords init with ``async``. And use ``await`` inside.

  The meaning of ``await something`` is that you could leave something run itself and come back later once ``something`` done. So clearly, future is awaitable.

* Tasks are used to schedule coroutines concurrently. If you want to have multiple corountines and get rid of wait time. You need wrap your coroutine into a Task by ``create_task()``. It give you control when you wait. Those methods are come from powder of ``Future``.  

* Task is a Future-like object.

What is Future-like object. It's means you could set the result of future, get the result, cancel futures, check futures status and automatically trigger other actions after you get future result. What I'm talking about are all actually methods ``Future``. 
