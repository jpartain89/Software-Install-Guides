=================================
Random Ansible Snippets
=================================

My :ref:`pass_a_list` snippet is probably the one reason I come back to my own docs site more than anything else, finding myself constantly forgetting how to properly pass a random list of objects - like a string of apps to install, on a whim of testing, across all three of my pi's at once - to ansible's CLI setup. As what I'll be doing isn't quite enough to facilitate a full play, as its not even tested yet!

---------------------------
Ansible CLI - Basic Example
---------------------------

Yes, I know this is like, the first thing that the `Ansible Documentation`_ site teaches you. But, again, it IS, like, the first thing this massive thing teaches you, and not in too much detail.

So, here's a repeat refresher with representative output examples.

.. code-block:: bash

  ansible ubuntu -a 'free -m'

Example output:

.. code-block:: text

  192.168.1.34 | SUCCESS | rc=0 >>
               total        used        free      shared  buff/cache   available
  Mem:          1973         354         618           7         1000        1450
  Swap:         2045           0        2045

This just runs ansible's ``command`` module. As in it doesn't support shell variables and things like piping. Thus, why the only flag given is the ``-a`` flag. If you wanted to change the module used, you'd include the ``-m`` flag before ``-a``, as the ``-a`` flag tells ansible the text within the \` \` is the actual text for the module requested.

Next, we change the module to ``ping``

.. code-block:: bash

  ansible all -m ping

This doesn't require the ``-a`` flag, unless there are other options you want to include with the ``ping`` module. Otherwise, this will run a simple ping on the hosts you requested.

Example output:

.. code-block:: text

  192.168.1.20 | SUCCESS => {
      "changed": false,
      "ping": "pong"
  }


.. _pass_a_list:

---------------
Pass a List
---------------

.. note:: tl;dr ``ansible ipsec --become -m apt -a 'name={{ pkg_list }} state=present' -e '{"pkg_list": ["strongswan","strongswan-plugin-eap-mschapv2","moreutils","iptables-persistent"]}'``

I've been wanting to figure this one out for forever!

Basically, how to pass multiple items into a command option when using ansible's ``ad-hoc`` mode on the command line.

.. code-block:: bash

  ansible ipsec --become -m apt -a 'name={{ pkg_list }} state=present' -e '{"pkg_list": ["strongswan","strongswan-plugin-eap-mschapv2","moreutils","iptables-persistent"]}'

.. _Ansible Documentation: https://docs.ansible.com/projects/ansible/latest/command_guide/intro_adhoc.html
.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Updated ad-hoc apt list example to use explicit ``state=present``.
  - Updated list variable naming and JSON quoting for clearer modern CLI usage.
  - Replaced screenshot-based command output references with inline text output examples.

Reason for Change
  Improve reliability and readability of ad-hoc package installation examples while removing stale image dependencies.

Compatibility Notes
  Compatible with modern Ansible ad-hoc CLI usage on current Ansible core releases.

Tested On
  Documentation review only (commands not executed in this repo).
