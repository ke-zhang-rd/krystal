=====
super
=====

.. code:: python

    super(type, object-or-type)

| The true meaning of ``super`` and its argument is:
| Lineriz(by ``mro``) inherent architecture from ``object-or-type`` then get the class right after ``type``.

For example, if ``__mro__`` of ``object-or-type`` is **D -> B -> C -> A -> object** and the value of ``type`` is **B**, then ``super()`` searches **C**.

A typical super call:

.. code:: python

  class C(B):
      def method(self, arg):
          super().method(arg)    # This does the same thing as:
                                 # super(C, self).method(arg)

.. note:: 

   * The default argument of ``type`` is class name, ``C`` here
   * The default argument of ``object-or_type`` is first argument of calling method, ``self`` here.

   Consult the `PEP3135 New Super <https://www.python.org/dev/peps/pep-3135/>`_
   for more.
