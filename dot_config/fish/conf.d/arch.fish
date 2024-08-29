if command -q lsb_release
  set distrib $(lsb_release -si)
  if test "$distrib" = "arch"; or test "$distrib" = "cachyos"; or test "$distrib" = "endeavouros"
    alias fixpacman="sudo rm /var/lib/pacman/db.lck"
    alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages
    alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB

    # Recent installed packages
    alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

    # Cleanup orphaned packages
    alias cleanup='sudo pacman -Rns (pacman -Qtdq)'       
  end
end
