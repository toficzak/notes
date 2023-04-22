## Installation of pip on Debian-like

``` sh
sudo apt install python3-pip
```
## Installing software with pip problems

The problem on Linux is that pip install ... drops scripts into ~/.local/bin and this is not on the default Debian/Ubuntu $PATH.

Add to `.zshrc`:
``` sh
export PATH="$HOME/.local/bin:$PATH"
```

Source: https://stackoverflow.com/questions/35898734/pip-installs-packages-successfully-but-executables-not-found-from-command-line

