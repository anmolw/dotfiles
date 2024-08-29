# Add ~/.local/bin to PATH
if test -d ~/.local/bin; and not contains ~/.local/bin $PATH
  fish_add_path ~/.local/bin
end

set fish_greeting

if status --is-interactive
  if command -q atuin
    atuin init fish | source
  end

  if command -q zoxide
    zoxide init fish | source
  end
end

if set -q WSL_DISTRO_NAME
  if not set -q SSH_AUTH_SOCK
    SHELL="$(which fish)" wsl2-ssh-agent | source
  end
end

if status --is-login
end

## Enable Wayland support for different applications
if [ "$XDG_SESSION_TYPE" = "wayland" ]
  set -gx WAYLAND 1
  set -gx QT_QPA_PLATFORM 'wayland;xcb'
  set -gx GDK_BACKEND 'wayland,x11'
  set -gx MOZ_DBUS_REMOTE 1
  set -gx MOZ_ENABLE_WAYLAND 1
  set -gx _JAVA_AWT_WM_NONREPARENTING 1
  set -gx BEMENU_BACKEND wayland
  set -gx CLUTTER_BACKEND wayland
  set -gx ECORE_EVAS_ENGINE wayland_egl
  set -gx ELM_ENGINE wayland_egl
end


if command -q eza
  alias ls "eza -l --icons --git --group-directories-first"
  alias la "eza -la --icons --git --group-directories-first"
  alias lt "eza --tree --icons --git --group-directories-first"
end

# Exclude extraneous mounts from df
alias dfx "df -h -x tmpfs -x overlay -x nfs -x smbfs -x cifs -x fuse.sshfs -x devtmpfs -x squashfs"
