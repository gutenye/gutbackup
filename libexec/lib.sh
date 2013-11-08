before() { :; }
after() { :; }

run_as_root() {
	if [[ `id -u` -ne 0 ]]; then 
		echo "oldtime: you cannot perform this operation unless you are root." >&2
		exit 1
	fi
}

check_mountpoint() {
	if ! mountpoint -q "$1"; then 
		echo "oldtime: \`$1' is unmounted." >&2
		exit 1
	fi
}

# vim: ft=sh
