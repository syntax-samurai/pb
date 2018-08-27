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

ARG="${2:-/dev/stdin}"

case $1 in
	ix|ix.io|i*)
		curl -sF 'f:1=<-' ix.io < $ARG
	;;
	0x0|null|nullbyte|0*)
		curl -sF file=@- https://0x0.st < $ARG
	;;
	sprunge|sprunge.us|s*)
		curl -sF 'sprunge=<-' http://sprunge.us < $ARG
	;;
	w1r3|wire|w1r3.net|w*)
		curl -sF upload=@- https://w1r3.net < $ARG
	;;
	clbin|c*)
		curl -sF 'clbin=<-' https://clbin.com < $ARG
	;;
	*)
		echo "unknown"
	;;
esac

