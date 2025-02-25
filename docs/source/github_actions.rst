==============
Github Actions
==============

Github Action make your work after commit smoothlly. There are many github actions available under github action markets.


One of the most important job of github action is documentation automatically. This section will introduce github action by deploy a documentation publish action.

This documentation deployment and publish action could be find in 'peaceiris/action-gh-pages <https://github.com/peaceiris/actions-gh-pages>'_.

This involve two reporitories. The docs repo and github.io repo. To generate keys pair, private key and public key, 

Those two keys are github email related and can be acquired by cmd below

.. code:: shell
  
  ssh-keygen -t rsa -b 4096 -C "$(git config user.email)" -f gh-pages -N ""

This command will generate two keys. One is gh-pages and the other one is gh-pages.pub.

You need add private key, gh-pages to working repo secrects under repo setting > Secrets and variables > Actions. Then press "New reporitory secret". Give it a title. 

You need add public key to github.io repo to under repo setting > Deploy keys. Then press add deploy key. Give it a title and paste the gh-pages.pub. check Allow write access.

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
