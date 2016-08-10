# Install Ratom

## Remote Atom....

The program, when called, sends the file that you've selected to edit over a specific SSH port that you've linked over when connecting to the client.

```bash
sudo curl -o /usr/local/bin/ratom https://raw.githubusercontent.com/aurora/rmate/master/rmate
sudo chmod +x /usr/local/bin/ratom
```

Then, exit that ssh session, and then to reconnect with the ports forwarded:

```bash
ssh -R 52698:localhost:52698 user@example.com
```

The `user@example.com` needs to be replaced by your normal login stuff. AKA `root@192.168.1.1`

Once you're connected you can open the file from the remote system onto your local Atom by:

```bash
ratom test.txt
```

* * *

These directions are copied from [randy3k/remote-atom](https://github.com/randy3k/remote-atom)
