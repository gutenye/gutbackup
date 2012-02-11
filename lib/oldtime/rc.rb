# user config
backup:
  rsync.options = ""

restore:
  rsync.options = ""

# system config

p:
  oldtime = Pa("/oldtime")
  home = Pa("/oldtime/oldtime")
  homerc = nil

instances:
  backup = Optimism.new
  restore = Optimism.new

hooks:
	all.default: 
		before = Optimism.new
		after:
      halt = proc { system("halt", :verbose => true) }
	backup.default:
		before = Optimism.new
		after = Optimism.new
  restore.default:
		before = Optimism.new
		after = Optimism.new
