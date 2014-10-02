# Behat
function behat -d 'Behat shortcut'
    if count $argv >/dev/null
        ./bin/behat $argv
    else
        ./bin/behat
    end
end
