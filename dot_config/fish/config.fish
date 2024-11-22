# Add ~/.local/bin to PATH
if test -d ~/.local/bin; and not contains -- ~/.local/bin "$PATH"
    fish_add_path ~/.local/bin
end

if test -d ~/.cargo/bin; and not contains -- ~/.cargo/bin "$PATH"
    fish_add_path ~/.cargo/bin
end

set fish_greeting

# Interactive shell setup
if status --is-interactive
    if command -q nvim
        set -gx EDITOR nvim
        alias vimdiff "nvim -d"
    end

    if command -q fzf
        fzf --fish | source
    end

    if command -q atuin
        atuin init fish | source
    end

    if command -q zoxide
        zoxide init fish | source
    end

    if command -q bat; and command -q batman
        alias man batman
        # Format man pages
        #set -x MANROFFOPT "-c"
        #set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    end

    if command -q mise
        mise activate fish | source
    end
else
    # Non-interactive setup
    mise activate --shims
end

if status --is-login
end

# WSL-specific stuff
if set -q WSL_DISTRO_NAME
    if not set -q SSH_AUTH_SOCK; and command -q wsl2-ssh-agent
        SHELL="fish" wsl2-ssh-agent | source
    end
end

if command -q lsb_release
    set -l distrib $(lsb_release -si)
    # Aliases for arch & derivatives
    if test "$distrib" = Arch; or test "$distrib" = cachyos; or test "$distrib" = endeavouros
        # List amount of -git packages
        alias gitpkg 'pacman -Q | grep -i "\-git" | wc -l'
        # Sort installed packages according to size in MB
        alias bigpkg "expac -H M '%m\t%n' | sort -h | nl"
        # Recently installed packages
        alias ripkg "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
        # Cleanup orphaned packages
        abbr -a -- cleanup "sudo pacman -Rns (pacman -Qtdq)"
    end
end

# git abbrs
abbr -a -- ga "git add"
abbr -a -- gd "git diff"
abbr -a -- gl "git log"
abbr -a -- gs "git status"

abbr -a -- uvt "uv tool"

if command -q eza
    alias ls "eza -l --icons --git --group-directories-first"
    alias la "eza -la --icons --git --group-directories-first"
    alias lt "eza --tree --icons --git --group-directories-first"
end

abbr -a -- erd "erd -H -y inverted --icons"

# Colorize grep output
alias grep "grep --color=auto"
alias fgrep "fgrep --color=auto"
alias egrep "egrep --color=auto"

# Exclude extraneous mounts from df
alias dfx "df -h -x tmpfs -x overlay -x nfs -x smbfs -x cifs -x fuse.sshfs -x devtmpfs -x squashfs"
