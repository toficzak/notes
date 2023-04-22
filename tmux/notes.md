## Copy colors of system vim to tmux vim

I love Linux Mint terminal colors and vim syntax colors, but they do not preserve 
in tmux.

Definitely the best result I have managed to achieve:

File: ~/.tmux.conf

```bash
set -g default-terminal "screen-256color"
```

File: ~/.vimrc

```bash
set number
set relativenumber
set background=dark
```
