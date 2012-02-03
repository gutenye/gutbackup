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

backup_blks = {}
restore_blks = {}
