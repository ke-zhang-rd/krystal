====================================
pytest with contest and parameterize
====================================

fixture
-------

fixture is a method to construct shared data for all tests. You may want put fixture in conftest.py which will load for all tests. Here is an example:

.. code:: python

  # conftest.py
  import pytest

  @pytest.fixture(scope="module", params=[10, 20])
  def data(request):
      return request.param

.. code:: python

  # test_ten.py
  def test_ten(data):
      assert data % 10 == 0

Pytest will load data one by one. It collects two tests for ``data = 10`` and then ``data = 20``.

fixture scopes
--------------

Fixtures are created when first requested by a test, and are destroyed based on their scope:
function: the default scope, the fixture is destroyed at the end of the test.
class: the fixture is destroyed during teardown of the last test in the class.
module: the fixture is destroyed during teardown of the last test in the module.
package: the fixture is destroyed during teardown of the last test in the package.
session: the fixture is destroyed at the end of the test session.

parametrize
-----------


.. code:: python

  # test_expectation.py
  import pytest

  @pytest.mark.parametrize("test_input, expected", [("3+5", 8), ("2+4", 6), ("6*9", 42)])
  def test_eval(test_input, expected):
      assert eval(test_input) == expected

  @pytest.mark.parametrize("x", [0, 1])
  @pytest.mark.parametrize("y", [2, 3])
  def test_foo(x, y):
      print(x, y)

  # x, y will be (0, 2), (0, 3), (1, 2), (1, 3)

In second example, pytest collects four tests which matach four combination of ``x, y``.
