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
	ix|ix.io)
		curl -sF 'f:1=<-' http://ix.io < $ARG
	;;
	0x0|null|nullbyte|0*)
		curl -sF 'file=@-' https://0x0.st < $ARG
	;;
	sprunge|sprunge.us|s*)
		curl -sF 'sprunge=<-' http://sprunge.us < $ARG
	;;
	iotek|iopaste|iop*)
		curl -sT- https://p.iotek.org < $ARG
	;;
	w1r3|wire|w1r3.net|w*)
		curl -sF 'upload=@-' https://w1r3.net < $ARG
	;;
	clbin|c*)
		curl -sF 'clbin=<-' https://clbin.com < $ARG
	;;
	uguu|uguu.se|u*)
		curl -sF 'file=@-' https://uguu.se/api.php?d=upload-tool < $ARG
	;;
	lewd|lewd.se|l*)
		curl -sF 'file=@-' https://lewd.se/api.php?d=upload-tool < $ARG
	;;
	fiery|fiery.me|f*)
		curl -sF 'files[]=@-' https://safe.fiery.me/api/upload < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//'
	;;
	doko|doko.me|d*)
		curl -sF 'files[]=@-' https://doko.moe/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	mixtape|mixtape.moe|m*)
		curl -sF 'files[]=@-' https://mixtape.moe/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	ptpb|ptpb.pw|p*)
		curl -sF 'c=@-' https://ptpb.pw/ < $ARG | grep "url:" | sed 's/url: //'
	;;
	*)
		echo "unknown"
	;;
esac

