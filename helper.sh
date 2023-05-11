fail() {
	echo "$*" >&2
	exit 1
}

load_envfile() {
	env_file="$1"
	if [ -f "$env_file" ]; then
		echo "Loading environments from .env file"
		export $(cat "$env_file" | grep -v "^#"  | xargs)
	else
		fail "Env file $env_file doesn't exists"
	fi
}

script_dirpath() {
	path=`readlink -f "${BASH_SOURCE:-$0}"`
	DIR_PATH=`dirname $path`
}