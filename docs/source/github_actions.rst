==============
Github Actions
==============


To access the action of github. We need 2 keys

private key

public key

Those two keys are github email related and can be acquired by cmd below

.. code:: shell
  
  ssh-keygen -t rsa -b 4096 -C "$(git config user.email)" -f gh-pages -N ""

ssh-keygen Manual
https://man.openbsd.org/ssh-keygen.1  





How to orgnaize github actions github pages

https://github.com/peaceiris/actions-gh-pages


shell: bash -l {0}

https://stackoverflow.com/a/69070805/10642305


syntax
------

https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions

How to disable actions to save minutes
--------------------------------------

https://docs.github.com/en/actions/managing-workflow-runs/disabling-and-enabling-a-workflow
