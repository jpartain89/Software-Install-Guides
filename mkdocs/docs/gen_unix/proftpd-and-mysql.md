# ProFTPD

Using [How To Forge](https://www.howtoforge.com) [Virtual Hosting with Proftpd and MySQL](https://www.howtoforge.com/virtual-hosting-with-proftpd-and-mysql-incl-quota-on-ubuntu-14.04-lts).

```bash
apt-get install mysql-server mysql-client phpmyadmin apache2
```

You will be asked for a root MySQL password. This will be valid for the `root@localhost` user.

You'll also be asked:

```bash
Web server to reconfigure automatically:
Configure database for phpmyadmin with dbconfig-common
```

I do not select any item, since I am using NGINX web server, and then I hit `yes`.

## Install Proftpd with MySQL Support

There is a pre-configured package for mysql and proftpd available.

```bash
apt-get install proftpd-mod-mysql
```

You'll be asked:

```bash
How do you want to run proftpd?
```

Select `Standalone.`

## Create the MySQL Database

```bash
mysql -u root -p
```

Make sure to replace `password` with your password you want to use for the user `proftpd`.

```bash
CREATE DATABASE ftp;
GRANT SELECT, INSERT, UPDATE, DELETE ON ftp.* TO 'proftpd'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE, DELETE ON ftp.* TO 'proftpd'@'localhost.localdomain' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

Next, we create the MySQL Database:

```bash
USE ftp;
```
```bash
CREATE TABLE ftpgroup (
groupname varchar(16) NOT NULL default '',
gid smallint(6) NOT NULL default '5500',
members varchar(16) NOT NULL default '',
KEY groupname (groupname)
) ENGINE=MyISAM COMMENT='ProFTP group table';
```
```bash
CREATE TABLE ftpquotalimits (
name varchar(30) default NULL,
quota_type enum('user','group','class','all') NOT NULL default 'user',
per_session enum('false','true') NOT NULL default 'false',
limit_type enum('soft','hard') NOT NULL default 'soft',
bytes_in_avail bigint(20) unsigned NOT NULL default '0',
bytes_out_avail bigint(20) unsigned NOT NULL default '0',
bytes_xfer_avail bigint(20) unsigned NOT NULL default '0',
files_in_avail int(10) unsigned NOT NULL default '0',
files_out_avail int(10) unsigned NOT NULL default '0',
files_xfer_avail int(10) unsigned NOT NULL default '0'
) ENGINE=MyISAM;
```
```bash
CREATE TABLE ftpquotatallies (
name varchar(30) NOT NULL default '',
quota_type enum('user','group','class','all') NOT NULL default 'user',
bytes_in_used bigint(20) unsigned NOT NULL default '0',
bytes_out_used bigint(20) unsigned NOT NULL default '0',
bytes_xfer_used bigint(20) unsigned NOT NULL default '0',
files_in_used int(10) unsigned NOT NULL default '0',
files_out_used int(10) unsigned NOT NULL default '0',
files_xfer_used int(10) unsigned NOT NULL default '0'
) ENGINE=MyISAM;
```
```bash
CREATE TABLE ftpuser (
id int(10) unsigned NOT NULL auto_increment,
userid varchar(32) NOT NULL default '',
passwd varchar(32) NOT NULL default '',
uid smallint(6) NOT NULL default '5500',
gid smallint(6) NOT NULL default '5500',
homedir varchar(255) NOT NULL default '',
shell varchar(16) NOT NULL default '/sbin/nologin',
count int(11) NOT NULL default '0',
accessed datetime NOT NULL default '0000-00-00 00:00:00',
modified datetime NOT NULL default '0000-00-00 00:00:00',
PRIMARY KEY (id),
UNIQUE KEY userid (userid)
) ENGINE=MyISAM COMMENT='ProFTP user table';
```
```bash
quit;
```

## Configure Proftpd

Edit `/etc/proftpd/modules.conf`

And uncomment/enable the following modules:

```bash
[...]
# Install one of proftpd-mod-mysql, proftpd-mod-pgsql or any other
# SQL backend engine to use this module and the required backend.
# This module must be mandatory loaded before anyone of
# the existent SQL backeds.
LoadModule mod_sql.c
[...]
# Install proftpd-mod-mysql and decomment the previous
# mod_sql.c module to use this.
LoadModule mod_sql_mysql.c
[...]
# Install one of the previous SQL backends and decomment
# the previous mod_sql.c module to use this
LoadModule mod_quotatab_sql.c
[...]
```

Then, edit `/etc/proftpd/proftpd.conf` and comment out the following lines:

```bash
[...]
#<IfModule mod_quotatab.c>
#QuotaEngine off
#</IfModule>
[...]
```

Then, add the following lines below:

```bash
#
# Alternative authentication frameworks
#
#Include /etc/proftpd/ldap.conf
#Include /etc/proftpd/sql.conf
```
and above

```bash
# Include other custom configuration files
Include /etc/proftpd/conf.d/
```

You are welcome to remove the `default anonymous` lines.

Make sure to change the `password` in the line `SQLConnectInfo` to the password you picked for the `proftpd` user above.

```bash
DefaultRoot ~

SQLBackend              mysql
# The passwords in MySQL are encrypted using CRYPT
SQLAuthTypes            Plaintext Crypt
SQLAuthenticate         users groups


# used to connect to the database
# databasename@host database_user user_password
SQLConnectInfo  ftp@localhost proftpd password


# Here we tell ProFTPd the names of the database columns in the "usertable"
# we want it to interact with. Match the names with those in the db
SQLUserInfo     ftpuser userid passwd uid gid homedir shell

# Here we tell ProFTPd the names of the database columns in the "grouptable"
# we want it to interact with. Again the names match with those in the db
SQLGroupInfo    ftpgroup groupname gid members

# set min UID and GID - otherwise these are 999 each
SQLMinID        500

# create a user's home directory on demand if it doesn't exist
CreateHome on

# Update count every time user logs in
SQLLog PASS updatecount
SQLNamedQuery updatecount UPDATE "count=count+1, accessed=now() WHERE userid='%u'" ftpuser

# Update modified everytime user uploads or deletes a file
SQLLog  STOR,DELE modified
SQLNamedQuery modified UPDATE "modified=now() WHERE userid='%u'" ftpuser

# User quotas
# ===========
QuotaEngine on
QuotaDirectoryTally on
QuotaDisplayUnits Mb
QuotaShowQuotas on

SQLNamedQuery get-quota-limit SELECT "name, quota_type, per_session, limit_type, bytes_in_avail, bytes_out_avail, bytes_xfer_avail, files_in_avail, files_out_avail, files_xfer_avail FROM ftpquotalimits WHERE name = '%{0}' AND quota_type = '%{1}'"

SQLNamedQuery get-quota-tally SELECT "name, quota_type, bytes_in_used, bytes_out_used, bytes_xfer_used, files_in_used, files_out_used, files_xfer_used FROM ftpquotatallies WHERE name = '%{0}' AND quota_type = '%{1}'"

SQLNamedQuery update-quota-tally UPDATE "bytes_in_used = bytes_in_used + %{0}, bytes_out_used = bytes_out_used + %{1}, bytes_xfer_used = bytes_xfer_used + %{2}, files_in_used = files_in_used + %{3}, files_out_used = files_out_used + %{4}, files_xfer_used = files_xfer_used + %{5} WHERE name = '%{6}' AND quota_type = '%{7}'" ftpquotatallies

SQLNamedQuery insert-quota-tally INSERT "%{0}, %{1}, %{2}, %{3}, %{4}, %{5}, %{6}, %{7}" ftpquotatallies

QuotaLimitTable sql:/get-quota-limit
QuotaTallyTable sql:/get-quota-tally/update-quota-tally/insert-quota-tally

RootLogin off
RequireValidShell off
```

I took out the `DefaultRoot ~` line, so as not to lock down my own personal stuff to just the home folders.

Then, restart proftpd:

```bash
sudo service proftpd restart
```

## Populate the Database and test.

```bash
sudo mysql -u root -p
```

```mysql
USE ftp;
```
