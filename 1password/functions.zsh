#!/bin/sh

oplogin() {
	"$(op signin my)" >~/.1passrc
	. ~/.1passrc
}

opgetpass() {
	op get item "$1" | jq '.details.password' | sed 's/"//g' | sed 's/\r\n//g' | pbcopy
}
