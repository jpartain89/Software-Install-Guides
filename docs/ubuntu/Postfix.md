# Configure Postfix as a "Send-Only" SMTP Server

## Introduction

Postfix is an MTA (Mail Transfer Agent), an application used to send and receive email. In this tutorial, we will install and configure Postfix so that it can be used to send emails by local applications only – that is, those installed on the same server that Postfix is installed on.

## Install Postfix

```bash
sudo apt-get install mailutils
```




* * *

Copied liberally from [DigitalOcean's](www.digitalocean.com) [How to Install and Configure Postfix](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-as-a-send-only-smtp-server-on-ubuntu-14-04)
