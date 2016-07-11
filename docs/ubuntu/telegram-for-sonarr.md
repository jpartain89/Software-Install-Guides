# Sonarr-Telegram Installation

Bot which lets you or others add series to [Sonarr](https://sonarr.tv/) via the messaging service [Telegram](https://telegram.org/).

Contact [@BotFather](http://telegram.me/BotFather) on Telegram to create and get a bot token.

Getting Started
=========

## Prerequisites
- Node.js
- Git

`sudo apt-get install node.js git git-core`

## Installation
### Git Repo Cloning

Then, clone the repo:

```bash
git clone https://github.com/onedr0p/telegram-sonarr-bot ~/git/
sudo ln -s ~/git/telegram-sonarr-bot /opt/telegram-sonarr-bot
cd /opt/telegram-sonarr-bot
sudo npm install
```

That last line has our node.js installation install all node.js required items.

### Configure Options
#### Copy default files into your edited files

Next, copy the default `acl.json.template` and `config.json.template` files to `acl.json` and `config.json`, so the system can read your info that you will input into them:

```bash
cp acl.json.template acl.json
cp config.json.template config.json
```

#### Input your Information

In `config.json`, fill in the various values:

Telegram:
- **botToken** your Telegram Bot token
> This info came from BotFather, the 2nd step at the top of this document.

Bot:
- **password** the password to access the bot
> You enter whatever password you want to use. Remember, these bots are technically accessible by ANY user on Telegram.... So the password is to stop them!
- **owner** your Telegram User ID
- **notifyId** your Telegram User ID
> You get these from the bot IDBot

Sonarr:
- **hostname**: hostname where your Sonarr program is running (required)
- **apiKey**: Your API key to access Sonarr (required)
- **port**: port number Sonarr is listening on (optional, default: 5050)
- **urlBase**: URL Base of Sonarr (optional, default: empty)
> This is if you are running a reverse proxy in front of Sonarr. If you don't know what this is, you might not be using a reverse proxy.
- **ssl**: Set to true if you are connecting via SSL, which is a settings in Sonarr (default: false)
- **username**: HTTP Auth username (default: empty)
- **password**: HTTP Auth password (default: empty)

**Important note**: Restart the bot after making any changes to the `config.json` file.

## Now, start the bot

`node sonarr.js`

## Usage (commands)

### First
Send '/start' to the bot, first to make sure that its working. And second, for it to, well... start.

### Second, Password Authentication
Next, send `/auth password` to the bot, replacing `password` with the password you entered in the `config.json` file above.

### Other Commands

Since you are able to see the commands inside of the bot chat, I wont repeat all of that here.

Hit `ctrl - x` in your terminal to stop the program.

## Startup Service

Create the init.d script. We will be using a default node-startup script found on github.

```bash
git clone https://github.com/chovy/node-startup.git ~/git/node-startup
sudo cp ~/git/node-startup/init.d/node-app /etc/init.d/telegram-sonarr
sudo nano /etc/init.d/telegram-sonarr
```

Make sure to edit the top of the file thusly, or if you know better options, use them of course.

```bash
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

```bash
sudo chmod +x /etc/init.d/telegram-sonarr
sudo update-rc.d telegram-sonarr defaults
```

Now, make sure the service script works.

`sudo service telegram-sonarr start`

Then, go back to your telegram chat room, and make sure its running by typing `/start`

## Notifications
Sonarr can be setup to send notifications to a user or a group chat when new content is added.

* In Sonarr go to `Settings` > `Connect` > `+` > `Custom Script`
* In the Name field enter `Telegram`
* In the Path field enter the full path to your node.js installation
    * `/usr/local/bin/node`
    * Or you can put in '$(which node)' as that will change into the location of `node`
* In the Arguments field enter the full path to `sonarr_notify.js` i.e `~/git/telegram-sonarr/sonarr_notify.js`
* If your bot is not started yet, start the bot by running `node sonarr.js`
* Otherwise, the notifications should work

* * *

Most directions copied liberally from [onedr0p's](https://github.com/onedr0p) [telegram-sonarr repo](https://github.com/onedr0p/telegram-sonarr)
