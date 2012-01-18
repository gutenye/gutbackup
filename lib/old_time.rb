libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

module OldTime
  autoload :VERSION, "old_time/version"
  autoload :Core, "old_time/core"
end

module Kernel
private

  include OldTime::Core

  def backup(&blk)
    @backup = blk
  end

  def restore(&blk)
    @restore = blk
  end
end
