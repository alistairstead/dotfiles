#!/usr/bin/env bash

echo "Sign-in enter your Apple ID, followed by [ENTER]:"

read apple_id

mas signin $apple_id

mas install 927292435 #iStat Mini (1.1)
mas install 443987910 #1Password (6.3.5)
mas install 1050660598 #zik-manager (1.4)
mas install 890031187 #Marked 2 (2.5.6)
mas install 585829637 #Todoist (6.3.17)
mas install 1059655371 #Newton (9.2.6)
mas install 920404675 #Monodraw (1.1.1)
mas install 584653203 #Paw (2.3.4)
mas install 847496013 #Deckset (1.6.3)
mas install 557168941 #Tweetbot (2.4.4)
