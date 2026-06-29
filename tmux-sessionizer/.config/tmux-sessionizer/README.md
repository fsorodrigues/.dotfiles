# tmux-sessionizer Config

`tmux-sessionizer.conf` contains shared defaults tracked by this dotfiles repo.

For machine-specific search paths, create an untracked file at:

```sh
~/.config/tmux-sessionizer/local.conf
```

The shared config sources `local.conf` last, so values in `local.conf` override
the tracked defaults.

Example:

```sh
TS_MAX_DEPTH=2
TS_SEARCH_PATHS=(~/projects ~/personal)
TS_EXTRA_SEARCH_PATHS=(~:1 ~/.dotfiles:3)
```
