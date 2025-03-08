===
RST
===

subrst
------

subsubrst
^^^^^^^^^

.. attention::
  
  This is a attention.

.. caution::

  This is a caution.

.. danger::

  This is a danger.

.. error::

  This is a error.

.. hint::

  This is a hint.

.. important::
  
  This is a important.

.. note::

  This is a note.

.. tip::

  This is a tip.

.. warning::
  
  This is a warning.

.. code-block:: python
  :caption: test.py
  
  # Options must be indented to the same level as the directive content.
  def func():
    pass

.. note::

   ``code`` is a reStructuredText directive. ``code-block`` is a Sphinx directive. The ``code-block`` has a different set of options to the ``code`` directive.

External link syntax:
    '`TEXT <EXTERNAL_LINK_ADDRESS>`_ '

for example,
    `google <www.gooogle.com>`_ need use '`google <www.gooogle.com>`_ '


=====  =====  =======
A      B      A and B
=====  =====  =======
False  False  False
True   False  False
False  True   False
True   True   True
=====  =====  =======
