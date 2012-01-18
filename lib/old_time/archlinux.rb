module OldTime
  module ArchLinux

    def backup_packages
      `pacman -Qqe | grep -vx "$(pacman -Qqm)" > /root/packages.lst`
      `pacman -Qqm > /root/aur.lst`
    end

  end
end
