# Ansible's ad-hoc reference guide

Yes, I know this is like, the first thing that ansible's [Documentation site](https://github.com/ansible/ansible/blob/devel/docsite/rst/intro_getting_started.rst#your-first-commands) teaches you. But, again, it IS, like, the first thing this massive thing teaches you, and not in too much detail.

So, here's a repeat, refresher, with screenshots!!

# ansible ubuntu -a "free -m"

This just runs ansible's `command` module. As in it doesn't support shell variables and things like piping.

![Ansible Basic Command Module](img/ansible_command_module.png)

# ansible all -m ping

![Ansible Module Ping](img/ansible_ping_all.png)
