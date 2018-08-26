#!/bin/sh
#                              ██           ██      ██
#  ██████                     ░██          ░██     ░░
# ░██░░░██  ██████    ██████ ██████  █████ ░██      ██ ███████
# ░██  ░██ ░░░░░░██  ██░░░░ ░░░██░  ██░░░██░██████ ░██░░██░░░██
# ░██████   ███████ ░░█████   ░██  ░███████░██░░░██░██ ░██  ░██
# ░██░░░   ██░░░░██  ░░░░░██  ░██  ░██░░░░ ░██  ░██░██ ░██  ░██
# ░██     ░░████████ ██████   ░░██ ░░██████░██████ ░██ ███  ░██
# ░░       ░░░░░░░░ ░░░░░░     ░░   ░░░░░░ ░░░░░   ░░ ░░░   ░░
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
# usage:
#   pb <service> [file|stream]
#
# examples:
#   pb ix ~/.vimrc
#   pb 0x0 <(ps aux)

_URL=

case $1 in
	ix|ix.io)
		_URL=`cat "$2" | curl -sF 'f:1=<-' ix.io`
	;;
	0x0|null|nullbyte)
		_URL=`cat "$2" | curl -sF file=@- https://0x0.st`
	;;
	sprunge|sprunge.us)
		_URL=`cat "$2" | curl -sF 'sprunge=<-' http://sprunge.us`
	;;
	w1r3|wire|w1r3.net)
		_URL=`cat "$2" | curl -sF upload=@- https://w1r3.net`
	;;
	clbin)
		_URL=`cat "$2" | curl -sF 'clbin=<-' https://clbin.com`
	;;
	*)
		echo "unknown"
	;;
esac

echo "$_URL"
