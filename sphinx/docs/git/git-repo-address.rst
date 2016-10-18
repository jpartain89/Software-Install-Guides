======================
Local Git Repo Address
======================

When you have a git repo locally downloaded on your machine, the comand line ``git`` program doesn't distinguish between you using Github, BitBucket, GitLab or your own creation as the remote repo. So, for this reason, if you ever decide to change where you host your repo, or the address you use to access that repo changes, its much easier than any proprietary system.

And, you can view that repo's saved address as well, in case you have forgotten or lost that.

Viewing the Repo's Address
==========================

First, while in your terminal program, you want to be sitting in the repo's directory to begin. I am assuming you know how to do that.

To view that git repo's address:

.. code-block:: bash

  git remote -v

You will see, at minimum, two lines showing the fetch and push addresses, along with the branch name, usually origin.

.. code-block:: bash

  git remote -v
    icefox	https://github.com/icefox/git-map.git (fetch)
    icefox	https://github.com/icefox/git-map.git (push)
    origin	https://github.com/JPCDI/git-map.git (fetch)
    origin	https://github.com/JPCDI/git-map.git (push)

Background
==========

In that above code-block, you'll notice four lines, rather than 2. Along with an additional name other than ``origin``. Thats because there is one remote location that I've named ``icefox ``and then my personal location named ``origin``.

Origin is the defacto name ``git`` gives to cloned repos. You'll also see it referred to as ``Master/Origin``. Because the Master is the remote location, with it being the Origin of the code. Or, at least thats my way of reconciling that info.

You are able to, say, pull from icefox, make a branch and changes, and rather than pushing or making a pull request for icefox, you can instead push out to origin.

Changing The Address
====================

Now, if you are wanting to change the address to another http(s) or utilize an SSH address with your SSH keys, you are able and allowed to change that.

Now, onto the commands.

.. code-block:: bash

  git remote set-url origin https://<remote-address>/

Each online git service has their own address layout specific to them. And, its obvious what those are as you begin using them.

Code Breakdown
==============

First, ``git`` doesn't require the use of dashes, but rather allows empty spaces to delimit different options. So, don't freak out about the lack of ``-`` in these lines.

#. ``git`` - obviously this is calling the ``git`` program itself
#. ``remote`` - tells ``git`` that we are doing something specific with the remote info
#. ``set-url`` - This is telling ``git`` that we're setting the URL for the remote, either first-round setting, amending the current info, or adding another repo.
#. ``origin`` - This is the name you are giving to the repo. If you want something other than ``origin``, you're welcome to but don't forget that.
#. ``https://<remote-address>`` - Obviously, this is the remote repo's address. The one  you utilize will be longer, as most services break down that location between the given username/company name and the specific repo name.

Final Steps
===========

Then, verify that the info has been updated with another:

.. code-block:: bash

  git remote -v

This, rather than ``git pull`` or ``git fetch --all`` is a safer way to make sure that info is correct. If you put in the wrong address, then pull or fetch, it could remove your info thats local, and we all know the hinky stuff that arises then.

Once verified,

 ``git pull`` or ``git fetch --all``

The ``--all`` can also be amended to the repo name you gave it. So, if more than one repo address is included, you can fetch specific repo's rather than all of them.
