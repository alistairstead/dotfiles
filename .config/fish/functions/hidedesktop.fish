function hidedesktop -d 'Ready! preeeeSENT ARMS!'
   defaults write com.apple.finder CreateDesktop -bool false;
   killall Finder
   echo "You see nothing!"
end