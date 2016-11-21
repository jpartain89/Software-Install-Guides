===========================
Dash in MySql Database Name
===========================

So, in MySql, if a database contains a ``-`` in the name, and you don't use backquotes: `` ` ` `` then mysql will error out.

.. code-block:: bash

  mysql> DROP DATABASE `seahub-db`;

This is a good little nugget to remember!
