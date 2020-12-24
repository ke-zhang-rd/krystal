=============================
try, except, else and finally
=============================

**Syntax**

.. code:: python

  try:
      if there is error, go to except
      Else, go to else
  except:
      Something
  else:
      Something
  finally:
      always execute this one at the end
      OR execute on the way of return/out

The ``finally`` clause is also executed **on the way out**.
The return value is determined by the first return statement executed. If return in ``try`` or ``else``, since the ``finally`` clause always being executed **on the way out**, it will jump to ``finally`` clause(``finally`` clause **hijack** ``return`` process). If ``finally`` clause has return statement, this statement will be excuated and as return value.

**Example**: without explict return

.. code:: python

  def foo(): 
      try: 
          a = 1/1 
      except: 
          print('except') 
      else: 
          print('else') 
      finally: 
          print('final') 

.. code:: python

  >>> foo()
  else
  final

**Example**: return in else

.. code:: python

    def foo():
        try: 
            a = 1/1 
        except: 
            print('except') 
        else: 
            print('else') 
            return 1 
        finally: 
            print('final')                                                                      

.. code:: python

    >>> foo()                                                                  
    else
    final
    Out[1]: 1

**Example**: return in else and finally

.. code:: python

    def foo():
        try: 
            a = 1/1 
        except: 
            print('except') 
        else: 
            print('else') 
            return 1 
        finally: 
            print('final')                                                                      
            return 0 

.. code:: python

    >>> foo()                                                                  
    else
    final
    Out[1]: 0
