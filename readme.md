# mssh - mount+ssh into any remote using profiles

Sick of typing this everyday?

```bash
ssh -p 8022 -i ~/.ssh/termux_id_ed25519 ssh://u0_aXXX@192.168.1.1
sshfs -oPort=8022 -oIdentityFile=~/.ssh/termux_id_ed25519 u0_aXXX@192.168.1.1
```


## Just do
```bash
mssh termux                             # mount + drop into shell
mssh -m termux                          # mount phone
```

## Install
```bash
sudo mkdir -p /usr/local/bin/
sudo install -m0755 <(sudo curl -f#SL https://raw.githubusercontent.com/Rustlog/mssh/main/mssh) /usr/local/bin/mssh
```

## Daily commands (mssh \[FLAGS\] \[PROFILE\])

```bash
mssh -e -p nas -c "Locally hosted NAS"  # create + comment
mssh -e pi                              # edit existing
mssh nas                                # mount + ssh
mssh -m termux                          # only mount my phone
mssh -s pi                              # only ssh to the Pi
mssh -l                                 # list profiles with comments
mssh -u nas                             # unmount nas
mssh -a termux                          # append pubkey -> passwordless
```

Profiles live in `~/.config/mssh/*` - just small and readable files.

LICENSE: GPLv3

