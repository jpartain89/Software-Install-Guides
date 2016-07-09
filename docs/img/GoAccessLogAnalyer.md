# GoAccess Log Analyzer

[GoAccess Log Analyzer](https://goaccess.io/) and interactive viewer that runs either in the terminal or browser.

To Install:

```bash
echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list
wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install goaccess
```
