module Oldtime
  module ArchLinux_Kernel

    def backup_packages
      `pacman -Qqe | grep -vx "$(pacman -Qqm)" > /oldtime/packages.lst`
      `pacman -Qqm > /oldtime/aur.lst`
    end

  end
end

module Kernel
private
  include Oldtime::ArchLinux_Kernel
end
