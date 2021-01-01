========
argparse
========

.. code:: python

  import argparse
  parser = argparse.ArgumentParser()
  parser.add_argument("x", type=int, help="the base")
  parser.add_argument("y", type=int, help="the exponent")
  parser.add_argument("-v", "--verbosity", action="count", default=0)
  args = parser.parse_args()
  answer = args.x**args.y
  if args.verbosity >= 2:
      print("{} to the power {} equals {}".format(args.x, args.y, answer))
  elif args.verbosity >= 1:
      print("{}^{} == {}".format(args.x, args.y, answer))
  else:
      print(answer)

Output:

.. code:: none

  $ python3 prog.py
  usage: prog.py [-h] [-v] x y
  prog.py: error: the following arguments are required: x, y
  $ python3 prog.py -h
  usage: prog.py [-h] [-v] x y

  positional arguments:
    x                the base
    y                the exponent

  optional arguments:
    -h, --help       show this help message and exit
    -v, --verbosity
  $ python3 prog.py 4 2 -v
  4^2 == 16
