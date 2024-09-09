# Add ~/.local/bin to PATH
if test -d ~/.local/bin; and not contains -- ~/.local/bin "$PATH"
  fish_add_path ~/.local/bin
end

if test -d ~/.cargo/bin; and not contains -- ~/.cargo/bin "$PATH"
  fish_add_path ~/.cargo/bin
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

if command -q bat
  # Format man pages
  set -x MANROFFOPT "-c"
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

if command -q mise
  mise activate fish | source
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

if command -q lsb_release
  set distrib $(lsb_release -si)
  # Aliases for arch & derivatives
  if test "$distrib" = "arch"; or test "$distrib" = "cachyos"; or test "$distrib" = "endeavouros"
    alias fixpacman="sudo rm /var/lib/pacman/db.lck"
    # List amount of -git packages
    alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
    # Sort installed packages according to size in MB
    alias big="expac -H M '%m\t%n' | sort -h | nl"
    # Recent installed packages
    alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
    # Cleanup orphaned packages
    alias cleanup='sudo pacman -Rns (pacman -Qtdq)'       
  end
end


if command -q eza
  alias ls "eza -l --icons --git --group-directories-first"
  alias la "eza -la --icons --git --group-directories-first"
  alias lt "eza --tree --icons --git --group-directories-first"
end

if command -q erd
  alias erd "erd -H -y inverted --icons"
end

# Colorize grep output
alias grep "grep --color=auto"
alias fgrep "fgrep --color=auto"
alias egrep "egrep --color=auto"

# Exclude extraneous mounts from df
alias dfx "df -h -x tmpfs -x overlay -x nfs -x smbfs -x cifs -x fuse.sshfs -x devtmpfs -x squashfs"
