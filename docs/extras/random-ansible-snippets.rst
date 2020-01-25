=================================
Random Ansible Snippets
=================================

My `Pass a List <pass_a_list>`_ snippet is probably the one reason I come back to my own docs site more than anything else, finding myself constantly forgetting how to properly pass a random list of objects - like a string of apps to install, on a whim of testing, across all three of my pi's at once - to ansible's CLI setup. As what I'll be doing isn't quite enough to facilitate a full play, as its not even tested yet!

---------------------------
Ansible CLI - Basic Example
---------------------------

Yes, I know this is like, the first thing that the `Ansible Documentation`_ site teaches you. But, again, it IS, like, the first thing this massive thing teaches you, and not in too much detail.

So, here's a repeat, refresher, with screenshots!!

.. code-block:: bash

  ansible ubuntu -a 'free -m'

.. image:: ansible_command_module.jpg
  :alt: Ansible Basic Command Module
  :align: center

This just runs ansible's ``command`` module. As in it doesn't support shell variables and things like piping. Thus, why the only flag given is the ``-a`` flag. If you wanted to change the module used, you'd include the ``-m`` flag before ``-a``, as the ``-a`` flag tells ansible the text within the \` \` is the actual text for the module requested.

Next, we change the module to ``ping``

.. code-block:: bash

  ansible all -m ping

This doesn't require the ``-a`` flag, unless there are other options you want to include with the ``ping`` module. Otherwise, this will run a simple ping on the hosts you requested.

.. image:: ansible_ping_all.jpg
  :alt: Ansible Ping Module
  :align: center

.. _pass_a_list:
---------------
Pass a List
---------------

I've been wanting to figure this one out for forever!

Basically, how to pass multiple items into a command option when using ansible's ``ad-hoc`` mode on the command line.

.. code-block:: bash

  ansible ipsec --become -m apt -a 'name={{ list }}' -e '{"list": [strongswan,strongswan-plugin-eap-mschapv2,moreutils,iptables-persistent]}'

.. _Ansible Documentation: https://docs.ansible.com/ansible/latest/user_guide/intro_adhoc.html#introduction-to-ad-hoc-commands
