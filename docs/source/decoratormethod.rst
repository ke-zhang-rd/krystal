===========================
A decorator as class method
===========================

.. code:: python

  class Test(object):
      def _decorator(foo):
          def magic( self ) :
              print("start magic")
              foo(self)
              print("end magic")
          return magic

      @_decorator
      def bar(self) :
          print("normal call")

  class TestB(Test):

      @TestB._decorator
      def bar(self):
          print("override bar in")
          super().bar()
          print("override bar out")

  print("Normal:")
  test = Test()
  test.bar()
  print()

  print("Inherited:")
  b = TestB()
  b.bar()
  print()
