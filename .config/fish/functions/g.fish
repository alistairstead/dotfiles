# ±Git
function g -d '±Git shortcut'
    if count $argv >/dev/null
        git $argv
    else
        git status
    end
end
