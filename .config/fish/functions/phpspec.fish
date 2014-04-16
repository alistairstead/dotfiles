# PHPSpec
function phpspec -d 'PHPspec shortcut'
    if count $argv >/dev/null
        ./bin/phpspec $argv
    else
        ./bin/phpspec
    end
end
