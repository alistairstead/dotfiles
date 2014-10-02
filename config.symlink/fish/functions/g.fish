# ±Git
function g --description '±Git shortcut'
    if count $argv >/dev/null
        git $argv
    else
        git status
    end
end

make_completion g 'git'
