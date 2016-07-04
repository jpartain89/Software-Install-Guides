## Sonarr-Telegram Installation

Make sure Node.js is installed:

`sudo apt-get install node.js`

Clone the repo:

```
git clone https://github.com/onedr0p/telegram-sonarr-bot ~/git/
sudo ln -s ~/git/telegram-sonarr-bot /opt/telegram-sonarr-bot
cd /opt/telegram-sonarr-bot
sudo npm install
```

Next, copy the acl.json.template to acl.json
`cp acl.json.template acl.json`

Then, copy config.json.template to config.json
`cp config.json.template config.json`

In `config.json` fill in the various values:

1. Telegram: botToken: Your Telegram Bot Token from 'BotFather's' `/token`
2. Bot:
    - Password: Your, manually entered password that is independent of any other telegram option, and only for this bot.
    - Owner: Your telegram user ID that you receive from 'IDBot's'  `/getid`
    - notifyID: Same as the Owner option above
3. Sonarr:
    - hostname: the IP address or FQDN of where Sonarr is running. EX: 192.168.1.20
    - apiKey: The API Key from Sonarr's settings page
    - port: the port number
    - urlBase: if you are reverse-proxying, you can enter the info here. AKA /sonarr
    - ssl: Set to true if SSL is turned on in Sonarr's settings
    - username: Sonarr's Username, if set
    - password: Sonarr's Password, if set

Next, start the bot.
`node sonarr.js` and run through the normal stuff to make sure it works.

Next, create the Upstart script:

```
git clone https://github.com/chovy/node-startup.git ~/git/node-startup
sudo cp ~/git/node-startup/init.d/node-app /etc/init.d/telegram-sonarr
sudo nano /etc/init.d/telegram-sonarr
```

Make sure to edit the top of the file thusly:

```
USER="root"
NODE_ENV="production"
PORT="3000"
APP_DIR="/opt/telegram-sonarr-bot"
NODE_APP="sonarr.js"
CONFIG_DIR="$APP_DIR"
PID_DIR="/var/run"
PID_FILE="$PID_DIR/telegram-sonarr.pid"
LOG_DIR="/var/log"
LOG_FILE="$LOG_DIR/telegram-sonarr.log"
NODE_EXEC=$(which node)
APP_NAME="Telegram-Sonarr-Bot"
```

Then,

```
sudo chmod +x /etc/init.d/telegram-sonarr
sudo update-rc.d telegram-sonarr defaults
```

Then, test it out:

`sudo service telegram-sonarr start`

In Telegram, in your bot's chat window, type `/start`. It will then state that you are not authorized.

`/auth [password]` where [password] is the password you put into the configuration file.

Then, again, type `/start`.
