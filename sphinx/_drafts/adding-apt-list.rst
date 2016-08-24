.. _adding_apt_list_code_ex:

Adding an Apt-Get List
=====================

When adding an apt-get list to your system, one nice way to save your code in your notes is not by specific system names, like ubuntu and debian releases. Rather, insert code into your ``echo`` so that it works for you!

.. code-block:: bash

  echo "deb https://packages.cisofy.com/community/lynis/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/cisofy-linus.list

The key text is ``$(lsb_release -sc)``. When you input ``$( )`` it tells bash to execute the command inside the parenthesis, and use the output inside the echo text.
