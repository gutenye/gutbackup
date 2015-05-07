# "host:/backup" -> "host"
# "/backup" -> ""
parse_host() {
  [[ "$1" =~ ^(.*):.*$ ]] && echo ${BASH_REMATCH[1]} || echo ""
}

# echo cmd and run cmd
run_cmd() {
  cmd="$1"; shift
  echo -e ">> $cmd $@"
  $cmd $@
}

pd() {
  echo -e "$@"
}

say() {
  echo -e "$@"
}

error() {
  echo -e "$@" >&2
}

error_exit() {
  echo -e "$@" >&2
  exit 1
}

debug() {
  echo -e "$@"
}


absolutename() {
	readlink -m "$1"
}

filename() {
	base=$(basename "$1")
	echo ${base%.*}
}

extname() {
	base=$(basename "$1")
	[[ "$base" =~ \. ]] && echo "${base##*.}" || echo ""
}
