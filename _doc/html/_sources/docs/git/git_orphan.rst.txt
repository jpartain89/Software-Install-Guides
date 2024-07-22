=================
Git --orphan
=================

tl;dr::

  git switch --orphan <new branch name>

If you find yourself wanting to create different branches in your git repository, as you're wanting to try different tools for the same project, we now have a great git tool to create a completely blank branch in a git repo: ``git switch --orphan``

Now, mind you, you wont be able to *easily* merge the two branches, if you were ever so inclined to do so (which, if you are using the above reason, then there would not ever be a need to merge the two branches, anyways)

.. code-block:: bash

  git switch --orphan <new branch name>
  git commit --allow-empty -m "Initial commit on orphan'd branch"
  git push -u origin <new branch name>

Or, you can add files to the branch and then commit like normal.

.. note:: 

  I totally took this from `Stack Overflow's website <https://stackoverflow.com/a/34100189>`_
