==============================
Synology Docker Permission Mod
==============================

I personally have different aliases and scripts setup in my bash dotfiles that will often pull or try to access various docker stuffs. So, when I login to a machine that has docker running but I don't have the proper permissions, I get a lot of errors. This is because docker requires root privileges to run, and by default, only users in the "docker" group can run docker commands without sudo. And, if you use Synology through the command line ever, you know that it can be tempermental at times, as it doesn't behave anything close to a normal Linux system. So, to fix this, you can add your user to the docker group on Synology with the following commands:

... code-block:: bash

  sudo synogroup --add docker
  sudo synogroup --memberadd docker <your username>

For the ``<your username>`` part, since :command:`sudo` on synology, using the usual ``$USER`` variable doesn't work, you need to actually enter the username you want to have the docker group added to.