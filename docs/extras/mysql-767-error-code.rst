=============================================
Fixing mysql/mariaDB 767 Character Error Code
=============================================

A seemingly super duper common error - that, for some reason, a lot of the "old hat" database users act like they've NEVER SEEN BEFORE and CAN'T EVER POSSIBLY REPRODUCE - that always is somehow difficult to find the CORRECT means of fixing, is going to be laid out here for a good spot to find it again....

.. code-block:: bash

  ERROR 1071 ... : Specified key was too long; max key length is 767 bytes

Type that into Google and even Alice herself would throw in the towel....

Plenty of websites will halfway get you to the fix, and then complain that you have no idea how to fix it already....

Well, I'm not going to be doing that here today.... I'll be giving you the MAIN fix, along with the commands you can also run while inside mysql/mariaDB.

--------
tl;dr
--------

Place the below block into your ``/etc/mysql/mariadb.conf.d/50-server.cnf``, within the ``[mysqld]`` section of the configuration file.

.. code-block:: bash

  innodb_file_format = Barracuda
  innodb_file_per_table = on
  innodb_default_row_format = dynamic
  innodb_large_prefix = 1
  innodb_file_format_max = Barracuda

This way, these settings are persistent on the server. These are specifically for the default installation that has the ``db charset`` set to ``utf8mb4``, table type of ``InnoDB`` and table charset of ``utf8mb4_unicode_ci``.

You can also set them within the ``mysql/mariadb`` environment, but that seems as though it doesn't want to ever stay set this way.

.. code-block:: bash

  SET GLOBAL innodb_file_format = Barracuda;
  SET GLOBAL innodb_file_per_table = on
  SET GLOBAL innodb_default_row_format = dynamic
  SET GLOBAL innodb_large_prefix = 1
  SET GLOBAL innodb_file_format_max = Barracuda

.. note::

  Make sure you restart the sql server after changing any settings in the configuration files.
