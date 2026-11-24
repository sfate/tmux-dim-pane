# tmux-dim-pane

Small tmux plugin for stable greyscale inactive pane dimming.

Tmux cannot fade arbitrary terminal colors with an opacity value.
The closest stable native behavior is to keep the active pane at the terminal default style and apply a greyscale `window-style` to inactive panes.

## Options

```tmux
set -g @tmux-dim-pane-theme "auto" # auto, dark, light

set -g @tmux-dim-pane-active-style "fg=terminal,bg=terminal"
set -g @tmux-dim-pane-dark-style "fg=colour244,bg=colour235"
set -g @tmux-dim-pane-light-style "fg=colour245,bg=colour252"

set -g @tmux-dim-pane-active-border-style "fg=#d8a657"
set -g @tmux-dim-pane-border-style "fg=#555555"
```

`auto` uses `defaults read -g AppleInterfaceStyle` on macOS: `Dark` selects the
dark theme, and any other result selects the light theme. When the `defaults`
command is unavailable, it falls back to `@tmux-gruvbox`, then `dark`.

## Install

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'sfate/tmux-dim-pane'

Hit `prefix + I` to fetch the plugin and source it.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/sfate/tmux-dim-pane ~/.tmux/plugins/tmux-dim-pane

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/.tmux/plugins/tmux-dim-pane/tmux-dim-pane.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf
