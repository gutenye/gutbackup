p:
  home = Pa("~/.oldtime")
  oldtime = Pa("/oldtime")

backup_blks = {}
restore_blks = {}

backup:
  rsync.options = ""

restore:
  rsync.options = ""
