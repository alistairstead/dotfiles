function git-new -d 'Create directory and initialize git'
    if count $argv >/dev/null
        mkdir -p $argv[1]
        cd $argv[1]
        git init
        touch .gitignore
        git add .gitignore
        git commit -m "Added .gitignore."
    end
end
