# exclude="$(load machineetc)"
load() {
  local files
  files=$(source "$profile_dir/$1"; echo "$files")
  echo "$files"
}

run_as_root() {
  [[ $(id -u) -ne 0 ]] && error_exit "gutbackup: you cannot perform this operation unless you are root."
}

#check_mountpoint() {
  #[[ ! mountpoint -q "$1" ]] && error_exit "gutbackup: \`$1' is unmounted."
#}

# vim: ft=sh
