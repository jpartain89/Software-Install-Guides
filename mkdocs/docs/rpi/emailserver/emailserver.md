# Raspberry Pi as Email Server

This is my centralized how-to on making my Raspberry Pi into a mailserver.

## Postfix

Postfix is the base mailserver app. The one that listens on port 25 for SMTP between other mail servers.

### Install

To install postfix:

```bash
sudo apt-get install postfix
```

Then, you'll be presented with a couple of questions:

![PostFix Mail Server Configuration Type](/images/2016/08/postfix_serverconf.jpg)

`Internet SIte` means that postfix handles all ingoing and outgoing mail movement.

![PostFix System Mail Name](/images/2016/08/postfix_systemmailname.jpg)

Then, the `system mail name` is your FQDN - Fully Qualified Domain Name. 
