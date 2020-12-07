=====
Super
=====

.. code-block:: python

    super(type, object-or-type)

| The true meaning of ``super`` and its argument is:
| Lineriz(by ``mro``) inherent architecture from ``object-or-type`` then search the class from ``type`` (right after type) then call whatever the function after it.

For example, if ``__mro__`` of ``object-or-type`` is **D -> B -> C -> A -> object** and the value of ``type`` is **B**, then ``super()`` searches **C -> A -> object**.

A typical super call:

.. code-block:: python

  class C(B):
      def method(self, arg):
          super().method(arg)    # This does the same thing as:
                                 # super(C, self).method(arg)

.. note:: 

   ``C`` and ``self`` are the default arguments:

   * The default argument of ``type`` is class name.
   * The default argument of ``object-or_type`` is first argument of calling method.

   Consult the `PEP3135 New Super <https://www.python.org/dev/peps/pep-3135/>`_
   for more.
