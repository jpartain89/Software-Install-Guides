# Install NGINX with their Ubuntu PPA

## Add NGINX's PPA:Repo and Install

For the $nginx variable at the end of the first code line, replace it with either `stable` for their Stable line or `development` for their Mainline.

!!! note
    Mainline is what they consider their "beta" line. Stable being their, well, "stable" line.

```bash
sudo add-apt-repository ppa:nginx/$nginx
sudo apt-get update && sudo apt-get install nginx
```

I will create a NGINX configuration "How-To" at some point in the future.
