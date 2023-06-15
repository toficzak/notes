## Contains

Wbudowane typy sekwencyjne (list, tuple, range) implementują metodę `__contains__()', co pozwala wyszukiwać w kolekcjach za pomocą operatora `in`.

## Regex

Module:

```
import re
```

Simple usage:
```
  file = open("input.txt", "r")

    pattern = re.compile("(\\d+)-(\\d+) ([a-z])")
    valid_password = 0
    for line in file:
        parts = line.strip().split(":")
        policy = parts[0].strip()
        password = parts[1].strip()

        matcher = pattern.match(policy)
        first_index = int(matcher.group(1))
        second_index = int(matcher.group(2))
        letter = matcher.group(3)
```


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

