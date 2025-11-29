# mountssh - mount+ssh into any remote using profiles

Sick of typing this everyday?

```bash
ssh -p 8022 -i ~/.ssh/termux_id_ed25519 ssh://u0_aXXX@192.168.29.1
sshfs -oPort=8022 -oIdentityFile=~/.ssh/termux_id_ed25519 u0_aXXX@192.168.29.1
```

## Just do
```bash
mountssh termux                             # mount + drop into shell
mountssh -m termux                          # mount phone
```

## Install (quick start)
```bash
sudo mkdir -p /usr/local/bin/
sudo curl -f#SL -o /usr/local/bin/mountssh https://raw.githubusercontent.com/Rustlog/mountssh/main/mountssh
sudo chmod 755 /usr/local/bin/mountssh
```

## Daily chores ( mountssh \[FLAGS\] \[PROFILE\] )

```bash
mountssh -e -p nas -c "Locally hosted NAS"  # create + comment
mountssh nas                                # mount + ssh
mountssh -m termux                          # only mount my phone
mountssh -s pi                              # only ssh to the Pi
mountssh -e pi                              # edit existing
mountssh -l                                 # list profiles with comment
```

Profiles live in `~/.config/mountssh/*` - just small and readable files.

LICENSE: MIT

