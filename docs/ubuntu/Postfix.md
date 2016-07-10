# Configure Postfix as a "Send-Only" SMTP Server

## Introduction

Postfix is an MTA (Mail Transfer Agent), an application used to send and receive email. In this tutorial, we will install and configure Postfix so that it can be used to send emails by local applications only – that is, those installed on the same server that Postfix is installed on.

## Install Postfix

```bash
sudo apt-get install mailutils
```

Now, during this installation, the system will prompt you with a Configuration Option. Since we will be using an outside service to send our mail - aka [smtp.gmail.com](smtp.gmail.com) - we will select `Internet Site`.

![PostFix Installation Configuration Question](img/PostFix_Config_Inst.jpg)

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

Change the line that reads `inet_interfaces = all` to `inet_interfaces = loopback-only`. The text should look like:

```bash
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = loopback-only
```

You can also use `localhost` if you'd prefer. Make sure to restart Postfix when you're finished.

```bash
sudo service postfix restart
```

## Make sure that the SMTP Server can Send Emails

This is testing if the actual forwarding part works.

To send a test email over the command line:

```bash
echo "This is the body of the email" | mail -s "This is the subject line" user@example.com
```

Making sure to put your email address in place of `user@example.com`. You should receive the email within a few seconds.

## Forward Root System Email

Now, last big thing.

A lot of the programs in Linux love to send mail to the root user. Which would be why sometimes, when you ssh into your machine, it'll show "New Mail" or "You have Mail".

To configure Postfix so that these system-generated emails are sent to you, edit the `/etc/aliases` file:

```bash
sudo nano /etc/aliases
```

The file should be tiny, something like:

```bash
# See man 5 aliases for format
postmaster:    root
```

The `postmaster: root` is the part that tells your system where to send that mail, with `postmaster` being a low-level, unix app.

So, in order to forward the mail to you?

```bash
# See man 5 aliases for format
postmaster:    root
root:       example@example.com
```

Simple redirection/rerouting. Obviously put in the email address you want to receive the emails at.

Then, once you saved the file,

```bash
sudo newaliases
```

And send another email:

```bash
echo "This is the body of the email" | mail -s "This is the subject line" root
```

Honestly, when I performed these steps, I actually received about 10 emails to my spam because my root mail was building up so much!

* * *

Copied liberally from [DigitalOcean's](www.digitalocean.com) [How to Install and Configure Postfix](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-as-a-send-only-smtp-server-on-ubuntu-14-04)
