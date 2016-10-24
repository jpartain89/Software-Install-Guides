# OpenVPN

OpenVPN is the open source, well-supported and well-documented pieces of VPN software there is.

Private Internet Access is the VPN service I personally use, and they also allow purchasing their service through gift cards, thus continuing to remove your name or email from the direct connection to your VPN service. This is the point of VPN, one of them. To secure your connections and annonymize things. But, PIA supplies plenty of files for working with OpenVPN.

## Install OpenVPN

```bash
sudo apt-get install openvpn
```

## Grab the PIA OpenVPN Profile

Download and uncompress the PIA OpenVPN profiles:

```bash
wget https://www.privateinternetaccess.com/openvpn/openvpn.zip
```

If `unzip` is not installed, go ahead and install it.

```bash
sudo apt-get install unzip
```

Then, unzip it. Make sure you use the `-d`, or else it'll unzip into the current directory. Super annoying.

```bash
unzip openvpn.zip -d openvpn
```

## Copy the Files

Copy the PIA OpenVPN certificates and profile to the OpenVPN configuration location.

!!! note
    I'm using `Japan.ovpn` as an example location. You can/should change that to whichever location you want to use.

```bash
sudo cp openvpn/ca.crt openvpn/crl.pem /etc/openvpn/
sudo cp openvpn/Japan.ovpn /etc/openvpn/Japan.conf
```

## Login File

Create `/etc/openvpn/login` containing only your username and password, one per line, for example:

```bash
user12345678
MyGreatPassword
```

Change the permissions on this file so only the root user can read it:

```bash
sudo chmod 600 /etc/openvpn/login
```

## And Edit the `.conf` File

Setup OpenVPN to use your stored username and password by editing the the config file for the VPN location:

```bash
sudo nano /etc/openvpn/Japan.conf
```

Change the following lines:

From This                | To This
------------------- | ----------------------------------------
ca ca.crt                   | ca /etc/openvpn/ca.rsa.2048.crt
auth-user-pass    | auth-user-pass /etc/openvpn/login
crl-verify crl.pem | crl-verify /etc/openvpn/crl.rsa.2048.pem

## Test VPN

At this point you should be able to test the VPN actually works:

```bash
sudo openvpn --config /etc/openvpn/Japan.conf
```

If all is well, you'll see something like:

```bash
sudo openvpn --config /etc/openvpn/Japan.conf
Sat Oct 24 12:10:54 2015 OpenVPN 2.3.4 arm-unknown-linux-gnueabihf [SSL (OpenSSL)] [LZO] [EPOLL] [PKCS11] [MH] [IPv6] built on Dec  5 2014
Sat Oct 24 12:10:54 2015 library versions: OpenSSL 1.0.1k 8 Jan 2015, LZO 2.08
Sat Oct 24 12:10:54 2015 UDPv4 link local: [undef]
Sat Oct 24 12:10:54 2015 UDPv4 link remote: [AF_INET]123.123.123.123:1194
Sat Oct 24 12:10:54 2015 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
Sat Oct 24 12:10:56 2015 [Private Internet Access] Peer Connection Initiated with [AF_INET]123.123.123.123:1194
Sat Oct 24 12:10:58 2015 TUN/TAP device tun0 opened
Sat Oct 24 12:10:58 2015 do_ifconfig, tt->ipv6=0, tt->did_ifconfig_ipv6_setup=0
Sat Oct 24 12:10:58 2015 /sbin/ip link set dev tun0 up mtu 1500
Sat Oct 24 12:10:58 2015 /sbin/ip addr add dev tun0 local 10.10.10.6 peer 10.10.10.5
Sat Oct 24 12:10:59 2015 Initialization Sequence Completed
```

With the `Initialization Sequence Completed` being the most important.

Exit this with `Ctrl+C`

## Setup OpenVPN's Autostart Configuration

Edit the `/etc/default/openvpn` file

```bash
sudo nano /etc/default/openvpn
```

Next, since I use only the one `.conf` file,  I uncomment the `AUTOSTART-"all"` line. If you have a different setup, go through and make those changes.

Then, to start the service:

```bash
sudo service openvpn start
```

## Setup Routing and NAT

Enable IP Forwarding:

```bash
sudo /bin/su -c "echo -e '\n#Enable IP Routing\nnet.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
sudo sysctl -p
```

Setup NAT from the local LAN down the VPN tunnel:

```bash
sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
sudo iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT
```

Make the NAT rules persistent across reboot:

```bash
sudo apt-get install iptables-persistent
```

The installer will ask if you want to save current rules, select `Yes`. This copies over the above rules to `iptables-persistent`'s files. Those are located at `/etc/iptables` if you ever wanna change them.

* * *

Copied from the bottom half of [superjamie's gist](https://gist.github.com/superjamie/ac55b6d2c080582a3e64).
