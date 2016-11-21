=======================
Ansible Random Nuggets
=======================

Setting a default to a variable, in order to test if its set or not:

.. code-block:: bash

  when: secret_gmail_passwd|default(None) != None

This will allow the task to run if and only if the variable ``secret_gmail_passwd`` is NOT None. 
