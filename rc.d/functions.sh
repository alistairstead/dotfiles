# Opens file in EDITOR.
function e() {
  if [ $# -eq 0 ]; then
		$EDITOR
	else
		$EDITOR $argv
	fi;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open $argv
	fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Execute commands for each file in current directory.
function each() {
  for dir in *; do
    echo "${dir}:"
    cd $dir
    $@
    cd ..
  done
}

# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
# # => 9762
function find-exec() {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# $ git log --no-merges --pretty=format:"%ae" | stats
# # => 514 a@example.com
# # => 200 b@example.com
function stats() {
  sort | uniq -c | sort -r
}

# $ retry ping google.com
function retry() {
  echo Retrying "$@"
  $@
  sleep 1
  retry $@
}

# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}

# find shorthand
function f() {
    find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
# function extract() {
# 	if [ -f "$1" ] ; then
# 		local filename=$(basename "$1")
# 		local foldername="${filename%%.*}"
# 		local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
# 		local didfolderexist=false
# 		if [ -d "$foldername" ]; then
# 			didfolderexist=true
# 			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
# 			echo
# 			if [[ $REPLY =~ ^[Nn]$ ]]; then
# 				return
# 			fi
# 		fi
# 		mkdir -p "$foldername" && cd "$foldername"
# 		case $1 in
# 			*.tar.bz2) tar xjf "$fullpath" ;;
# 			*.tar.gz) tar xzf "$fullpath" ;;
# 			*.tar.xz) tar Jxvf "$fullpath" ;;
# 			*.tar.Z) tar xzf "$fullpath" ;;
# 			*.tar) tar xf "$fullpath" ;;
# 			*.taz) tar xzf "$fullpath" ;;
# 			*.tb2) tar xjf "$fullpath" ;;
# 			*.tbz) tar xjf "$fullpath" ;;
# 			*.tbz2) tar xjf "$fullpath" ;;
# 			*.tgz) tar xzf "$fullpath" ;;
# 			*.txz) tar Jxvf "$fullpath" ;;
# 			*.zip) unzip "$fullpath" ;;
# 			*) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
# 		esac
# 	else
# 		echo "'$1' is not a valid file"
# 	fi
# }

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";
	echo "${tmpFile}.gz created successfully.";
}

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Create a git.io short URL
function gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}";
	local ip=$(ipconfig getifaddr en1);
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}

# Freshen up your brew.
freshbrew() {
  me="$(whoami)"

  file1="$(stat /usr/local/bin | awk '{ print $5 }')"
  file2="$(stat /usr/local/share | awk '{ print $5 }')"

  if [ "$me" != "$file1" ]; then
    echo -e "Need to chown /usr/local/bin"
    sudo chown -R $(whoami):admin /usr/local/bin
  fi

  if [ "$me" != "$file2" ]; then
    echo -e "Need to chown /usr/local/share"
    sudo chown -R $(whoami):admin /usr/local/share
  fi

  brew doctor
  brew update
  brew upgrade
  brew cleanup
  brew prune
}

#iex() {
  #docker run -it --rm -v "${PWD}:/app" -w /app elixir iex "$@"
#}

#mix() {
  #docker run -it --rm -v "${PWD}:/app" -w /app elixir mix "$@"
#}

postgres_start() {
  docker run --name postgres -d --restart=unless-stopped -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -p 5432:5432 postgres
}

postgres_stop() {
  docker rm postgres -f
}

redis_start() {
  docker run --name redis -d --restart=unless-stopped -p 6379:6379 redis
}

redis_stop() {
  docker rm redis -f
}

vim() {
    if [ -s /usr/local/bin/nvim ]; then
      nvim $argv
    else
      vim $argv
    fi
}

nvm() {
    unset -f nvm
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    nvm $argv
}

node() {
    unset -f node
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    node $argv
}

npm() {
    unset -f npm
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    source <(npm completion)
    npm $argv
}

docker-clean() {
  docker volume rm $(docker volume ls -qf dangling=true)
}
