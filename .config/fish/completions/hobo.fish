function __hobo_completion -d "Create hobo completions"
  set -l cache_dir "/tmp/fish_hobo_completion_cache"
  mkdir -p $cache_dir
  set -l hashed_pwd (ruby -r 'digest' -e 'puts Digest::MD5.hexdigest(`pwd`)')
  set -l hobo_cache_file "$cache_dir/$hashed_pwd"

  if not test -f "$hobo_cache_file"
    hobo system completions fish --skip-host-checks > "$hobo_cache_file"
  end

  cat "$hobo_cache_file"
end

function __hobo_scope_test -d "Hobo scoped completion test"
  set cmd (commandline -opc)
  if [ "$cmd" = "$argv" ]
    return 0
  end
  return 1
end

eval (__hobo_completion)
