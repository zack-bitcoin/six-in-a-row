Make sure that your system is up-to-date:
```
sudo apt-get update
```
and
```
sudo apt-get upgrade
```

For Ubuntu, install following dependencies:

```
sudo apt-get install erlang libncurses5-dev libssl-dev unixodbc-dev g++ git
```

Next, download software. Optionally you can run next steps with a non-root user, for better security.

```
git clone https://github.com/zack-bitcoin/bitcoin-inheritance.git
```
Now you can go into the directory, and compile the aeternity testnet.

```
cd testnet/
sh install.sh
```

Installation should be done. Now you can run your node.
