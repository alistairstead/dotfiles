# mkdir & cd to it
function mcd -d 'Create directory and land in it'
    if count $argv >/dev/null
        mkdir -p $argv[1]
        cd $argv[1]
    end
end
