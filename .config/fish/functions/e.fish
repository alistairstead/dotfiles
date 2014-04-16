function e -d 'Editor'
    if count $argv >/dev/null
        eval "$EDITOR $argv"
    else
        eval "$EDITOR ."
    end
end
