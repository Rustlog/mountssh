# mssh - mount+ssh into any remote using profiles

Sick of typing this everyday?

```bash
ssh -p 8022 -i ~/.ssh/termux_id_ed25519 ssh://u0_aXXX@192.168.29.1
sshfs -oPort=8022 -oIdentityFile=~/.ssh/termux_id_ed25519 u0_aXXX@192.168.29.1
```

## Just do
```bash
mssh termux                             # mount + drop into shell
mssh -m termux                          # mount phone
```

## Install (quick start)
```bash
sudo mkdir -p /usr/local/bin/
sudo curl -f#SL -o /usr/local/bin/mssh https://raw.githubusercontent.com/Rustlog/mssh/main/mssh
sudo chmod 755 /usr/local/bin/mssh
```

## Daily chores ( mssh \[FLAGS\] \[PROFILE\] )

```bash
mssh -e -p nas -c "Locally hosted NAS"  # create + comment
mssh nas                                # mount + ssh
mssh -m termux                          # only mount my phone
mssh -s pi                              # only ssh to the Pi
mssh -e pi                              # edit existing
mssh -l                                 # list profiles with comment
```

Profiles live in `~/.config/mssh/*` - just small and readable files.

LICENSE: GPLv3

