# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_";
}

# generate a gist either from the clipboard, or by piping, or using a filename
# and then immediately get a git.io url for it and stick it on the clipboard
hash gist &>/dev/null;
if [ $? -eq 0 ]; then
  function gist() {
    if [ -t 0 ]; then
      if ((! $# )); then
        command gist -Pcop -f paste.txt | gitio
      else
        command gist -cop $@ | gitio
      fi
    else
      command gist -cop $@ < /dev/stdin | gitio
    fi
  }
fi

# Create a git.io short URL
function gitio() {
  local url="$1";
  if [ -t 0 ]; then # read from arg
    if [ -z "${url}" ]; then
      echo "Usage: \`gitio url\`";
      return 1;
    fi;
  else
    read url
  fi

  curl -s -L -q -i https://git.io/ -F "url=${url}" | grep Location | cut -d' ' -f2 | pbcopy; # generate url and copy to clipboard
  pbpaste # echo
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* *;
  fi;
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
  function diff() {
    git diff --no-index --color-words "$@" | diff-so-fancy;
  }
fi;

# Create a data URL from a file
function dataurl() {
  local mimeType=$(file -b --mime-type "$1");
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8";
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}";
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
  local port="${1:-4000}";
  local ip=$(ipconfig getifaddr en0);
  sleep 1 && open "http://${ip}:${port}/" &
  php -S "${ip}:${port}";
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
# uses the npmjs.com/json package
function json() {
  if [ -t 0 ]; then # argument
    command json "$*" | pygmentize -l javascript;
  else # pipe
    command json $@ < /dev/stdin | pygmentize -l javascript;
  fi;
}

# Run `dig` and display the most useful info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer;
}


# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

base64() {
  openssl base64 < "$1" | tr -d '\n' | pbcopy
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
