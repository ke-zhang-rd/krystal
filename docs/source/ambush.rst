======
ambush
======

**Example:**

I would like to how does this **Popular** Package use my function.

.. code-block:: python
  :linenos:
  :caption: test.py

  from main import Popular

  def foo():
    print("In foo()")

  p = Popular()
  p.register(foo)
  p.run()

.. code-block:: python
  :linenos:
  :caption: main.py

  from run import Runner


  class Popular:

    def register(self, cb):
      self.callback = cb

    def run(self):
      # some work
      r = Runner(self.callback)
      # some other work


.. code-block:: python
  :linenos:
  :caption: run.py
        
  class Runner:

    def __init__(self, cb):
      cb()

.. code-block:: python
  :linenos:
  :caption: test.py

  from main import Popular

  def foo():
    print("In foo()")
    from ambush import detector
    detector()

  p = Popular()
  p.register(foo)
  p.run()
.. code-block:: python

  python test.py

**Output:**

.. code:: none

  Who is calling current function
  ==========================================================
  In file:
  /Users/tmp/run.py

  class Runner:
      # by caller function:
      def __init__ in line 3
          ...
          # actually call:
      cb() # in line 4
          ...

  Peek:
  ---------------------------------------------------------
    def __init__(self, cb):
      cb()

  ==========================================================
