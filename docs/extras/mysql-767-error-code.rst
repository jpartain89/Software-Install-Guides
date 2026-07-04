=============================================
Fixing mysql/mariaDB 767 Character Error Code
=============================================

A seemingly super duper common error - that, for some reason, a lot of the "old hat" database users act like they've NEVER SEEN BEFORE and CAN'T EVER POSSIBLY REPRODUCE - that always is somehow difficult to find the CORRECT means of fixing, is going to be laid out here for a good spot to find it again....

.. code-block:: bash

  ERROR 1071 ... : Specified key was too long; max key length is 767 bytes

Type that into Google and even Alice herself would throw in the towel....

Plenty of websites will halfway get you to the fix, and then complain that you have no idea how to fix it already....

Well, I'm not going to be doing that here today.

.. warning::

  The old ``767 bytes`` workaround settings below are for legacy MySQL 5.7 and older MariaDB deployments.
  On MySQL 8.0+ and modern MariaDB releases, these settings are deprecated/removed or unnecessary.

--------
tl;dr
--------

For modern versions first:

.. code-block:: bash

  # MySQL 8.0+ and modern MariaDB:
  # keep utf8mb4 + InnoDB defaults and avoid legacy innodb_file_format options.

Legacy workaround (MySQL 5.7 / older MariaDB): place the below block into your ``/etc/mysql/mariadb.conf.d/50-server.cnf``, within the ``[mysqld]`` section.

.. code-block:: bash

  innodb_file_format = Barracuda
  innodb_file_per_table = on
  innodb_default_row_format = dynamic
  innodb_large_prefix = 1
  innodb_file_format_max = Barracuda

This way, these settings are persistent on the server. These are specifically for the default installation that has the ``db charset`` set to ``utf8mb4``, table type of ``InnoDB`` and table charset of ``utf8mb4_unicode_ci``.

You can also set them within the ``mysql/mariadb`` environment, but those runtime settings may not persist across restart.

.. code-block:: bash

  SET GLOBAL innodb_file_format = Barracuda;
  SET GLOBAL innodb_file_per_table = on
  SET GLOBAL innodb_default_row_format = dynamic
  SET GLOBAL innodb_large_prefix = 1
  SET GLOBAL innodb_file_format_max = Barracuda

.. note::

  Make sure you restart the sql server after changing any settings in the configuration files.

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Added explicit version guidance separating modern MySQL/MariaDB behavior from legacy 767-byte fixes.
  - Clarified that legacy ``innodb_file_format`` options are for older versions only.

Reason for Change
  Prevent outdated server parameters from being applied to modern MySQL/MariaDB versions.

Compatibility Notes
  Legacy block applies to MySQL 5.7/older MariaDB; modern guidance applies to MySQL 8.0+ and current MariaDB defaults.

Tested On
  Documentation review only (commands not executed in this repo).
