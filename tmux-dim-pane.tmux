#!/usr/bin/env sh

get_tmux_option() {
  option="$1"
  default="$2"
  value="$(tmux show-option -gqv "$option")"

  if [ -n "$value" ]; then
    printf '%s\n' "$value"
  else
    printf '%s\n' "$default"
  fi
}

detect_theme() {
  configured_theme="$(get_tmux_option "@tmux-dim-pane-theme" "auto")"

  case "$configured_theme" in
    dark|light)
      printf '%s\n' "$configured_theme"
      return
      ;;
  esac

  if command -v defaults >/dev/null 2>&1; then
    if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ]; then
      printf 'dark\n'
      return
    fi

    printf 'light\n'
    return
  fi

  gruvbox_theme="$(tmux show-option -gqv "@tmux-gruvbox")"
  case "$gruvbox_theme" in
    light)
      printf 'light\n'
      ;;
    *)
      printf 'dark\n'
      ;;
  esac
}

theme="$(detect_theme)"
active_style="$(get_tmux_option "@tmux-dim-pane-active-style" "fg=terminal,bg=terminal")"
active_border_style="$(get_tmux_option "@tmux-dim-pane-active-border-style" "fg=#d8a657")"
border_style="$(get_tmux_option "@tmux-dim-pane-border-style" "fg=#555555")"

case "$theme" in
  light)
    inactive_style="$(get_tmux_option "@tmux-dim-pane-light-style" "fg=colour245,bg=colour252")"
    ;;
  *)
    inactive_style="$(get_tmux_option "@tmux-dim-pane-dark-style" "fg=colour244,bg=colour235")"
    ;;
esac

tmux set-option -gq window-active-style "$active_style"
tmux set-option -gq window-style "$inactive_style"
tmux set-option -gq pane-active-border-style "$active_border_style"
tmux set-option -gq pane-border-style "$border_style"
