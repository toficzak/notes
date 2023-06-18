List just one file name per line
```bash
ls -1
```

Check out current shell:

```bash
echo $SHELL
```

Add remap in lua for vim:

```
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
```

which is:
 - n for normal mode
 - <leader> - space
 - pv - actual thing to type
 - vim.cmd.EX - what to perform

vim:
 - :so to source current file

 - error during `:so`  Error executing lua [string ":source (no file)"]:2: attempt to index field 'keymap' (a nil value)
  -> sudo add-apt-repository ppa:neovim-ppa/unstable; sudo apt-get update; sudo apt-get install neovim

---

systemctl list-units --type=service # list all services
