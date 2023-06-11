## Copy colors of system vim to tmux vim

Definitely the best result I have managed to achieve:

File: ~/.tmux.conf

```bash
1   set -g default-terminal "screen-256color"
```

File: ~/.vimrc

```bash
set number
set relativenumber
set background=dark
```
