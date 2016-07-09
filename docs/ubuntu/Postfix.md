# Configure Postfix as a "Send-Only" SMTP Server

## Introduction

Postfix is an MTA (Mail Transfer Agent), an application used to send and receive email. In this tutorial, we will install and configure Postfix so that it can be used to send emails by local applications only – that is, those installed on the same server that Postfix is installed on.

## Install Postfix

```bash
sudo apt-get install mailutils
```

Now, during this installation, the system will prompt you with a Configuration Option. Since we will be using an outside service to send our mail - aka [smtp.gmail.com](smtp.gmail.com) - we will select `Internet Site`.

![PostFix Installation Configuration Question](docs/img/PostFix_Config_Inst.png)

Then, it will continue on with `System Mail Name`

I like to know which of my Virtual Machines or Unix systems might be messaging me, so I like to set these according to 'os-hostname.webaddress.com', or 'ubuntu-nginx.jpcdi.com

system-name | FQDN Address | com
--|---|--
os-hostname | webaddress | com
ubuntu-nginx | jpcdi | com

## Configure Postfix

We will be setting the system to process emails only from "the server on which it is running," aka the `localhost` or `loopback interface`. That way, when postfix "receives" an email from the system - for say, root - it will use Postfix to forward the email off through our specified smtp server.

So, to start:

```bash
sudo nano /etc/postfix/main.cf
```

Towards the bottom, find

```bash
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
```

You can hit `ctrl + w` and that will open a search prompt. There, type `inet_interfaces`, and it should bring you to the required location. If there are more than one instance of that search string occuring in the document, continue hitting `ctrl + w` then `enter`, as the search function holds the prior search term until a new one is typed in.



* * *

Copied liberally from [DigitalOcean's](www.digitalocean.com) [How to Install and Configure Postfix](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-as-a-send-only-smtp-server-on-ubuntu-14-04)
