function showdesktop -d 'And relax'
   defaults write com.apple.finder CreateDesktop -bool true; and killall Finder
   echo "I see dead icons!"
end