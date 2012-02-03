module Oldtime
  module ArchLinux_Kernel
    def backup_archlinux_packages
      system %~pacman -Qqe | grep -vx "$(pacman -Qqm)" > #{Rc.p.oldtime}/packages.lst~, :verbose => true
      system %~pacman -Qqm > #{Rc.p.oldtime}/aur.lst~, :verbose => true
    end
  end
end

include Oldtime::ArchLinux_Kernel

Optimism.undef_method :backup_archlinux_packages
