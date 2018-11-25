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
#   dmesg | pb iop

usage () {
    cat <<EOF
pb; a command line pastebin service helper
usage: pb <service> [file|stream]
services: ix.io, 0x0.st, sprunge.us, p.iotek.org, w1r3.net, clbin.com, uguu.se, lewd.se, fiery.me, doko.me, mixtape.moe, pomf.cat, catbox.moe, asis.io, dmca.gripe, ptpb.pw, rokket.space
EOF
  exit 0
}

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
	iotek|iopaste|p.iotek.org|iop*)
		curl -sT- https://p.iotek.org < $ARG
	;;
	w1r3|wire|w1r3.net|w*)
		curl -sF 'upload=@-' https://w1r3.net < $ARG
	;;
	clbin|clbin.com|cl*)
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
	doko|doko.me|do*)
		curl -sF 'files[]=@-' https://doko.moe/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	mixtape|mixtape.moe|m*)
		curl -sF 'files[]=@-' https://mixtape.moe/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	pomf|pomf.cat|po*)
		curl -sF 'files[]=@-' https://pomf.cat/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's!"url":"!https://a.pomf.cat/!;s/"//'
	;;
	catbox|catbox.moe|cat*)
		curl -sF 'reqtype=fileupload' -F 'fileToUpload=@-' https://catbox.moe/user/api.php < $ARG
	;;
	asis|asis.io|a*)
		curl -sF 'files[]=@-' https://up.asis.io/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's!"url":"!https://dl.asis.io/!;s/"//'
	;;
	dmca|dmca.gripe|gripe|dm*)
		curl -sF 'files[]=@-' http://dmca.gripe/api/upload < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	ptpb|ptpb.pw|pt*)
		curl -sF 'c=@-' https://ptpb.pw/ < $ARG | grep "url:" | sed 's/url: //'
	;;
	rokket|rokket.space|r*)
		curl -sF 'files[]=@-' https://rokket.space/upload < $ARG | grep 'url' | sed 's/"url": "//;s/",//;s/ //g'
	;;
	*)
		usage
	;;
esac

