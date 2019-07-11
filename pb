#!/bin/sh
#
# pb; a command line pastebin service helper
#    {kopimi,CC0} MMXVIII . syntax samurai
#         ▟▙
# ▟▒░░░░░░░▜▙▜████████████████████████████████▛
# ▜▒░░░░░░░▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
#         ▜▛
# authors:
#   xero  <https://xero.nu>
#   stark <https://git.io/stark>
# code:
#   https://code.xero.nu/pb
#   https://git.io/pb.sh
# greets:
#   all the ops of these great free services <3
#
usage () {
    cat <<EOF

          █
     ▄▀▀▄ █▐▀▄
░ ░ ░█▐░█░█▐░█░ ░ ░
     █▐▄▀ ▀▄▄▀
     █

pb; a command line pastebin service helper

usage:
   pb <service> [file|stream]

services:
   0x0.st, catbox.moe, clbin.com, dmca.gripe,
   dumpz.org, fiery.me, ix.io, p.iotek.org,
   pastebin.com, sprunge.us, uguu.se, w1r3.net

environment variables:
   UA: user-agent string (defaults to some chrome one)

envs for pastebin.com:
   PB_API_DEV: developer api key [required] https://pastebin.com/api#1
   PB_API_USR: user api key [optional] https://pastebin.com/api#8
   PRIVACY: paste visibility  [optional] valid values: public|0, unlisted|1, private|2
   ANON: paste w/o a user key even if defined [optional]

examples:
   pb ix ~/.vimrc
   pb 0x0 <(ps aux)
   dmesg | pb iop
   PB_API_DEV=XXXX PRIVACY=0 pb pb /tmp/leak.txt
   UA="Mozilla/5.0 (PlayStation 4 5.55) AppleWebKit/601.2 (KHTML, like Gecko)" pb uguu /tmp/x

EOF
  exit 0
}

ARG="${2:-/dev/stdin}"
UA=${UA:="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"}
case $1 in
	ix|ix.io)
		curl -A "$UA" -sF 'f:1=<-' http://ix.io < $ARG
	;;
	0x0|null|nullbyte|0*)
		curl -A "$UA" -sF 'file=@-' https://0x0.st < $ARG
	;;
	sprunge|sprunge.us|s*)
		curl -A "$UA" -sF 'sprunge=<-' http://sprunge.us < $ARG
	;;
	iotek|iopaste|p.iotek.org|iop*)
		curl -A "$UA" -sT- https://p.iotek.org < $ARG
	;;
	clbin|clbin.com|cl*)
		curl -A "$UA" -sF 'clbin=<-' https://clbin.com < $ARG
	;;
	uguu|uguu.se|u*)
		curl -A "$UA" -sF 'file=@-' https://uguu.se/api.php?d=upload-tool < $ARG
	;;
	lewd|lewd.se|l*)
		curl -A "$UA" -sF 'file=@-' https://lewd.se/api.php?d=upload-tool < $ARG
	;;
	fiery|fiery.me|f*)
		curl -A "$UA" -sF 'files[]=@-' https://safe.fiery.me/api/upload < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//'
	;;
	catbox|catbox.moe|cat*)
		curl -A "$UA" -sF 'reqtype=fileupload' -F 'fileToUpload=@-' https://catbox.moe/user/api.php < $ARG
	;;
	dmca|dmca.gripe|gripe|dm*)
		curl -A "$UA" -sF 'files[]=@-' http://dmca.gripe/api/upload < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	dumpz|dumpz.org|du*)
		curl -A "$UA" -s --data-binary @- https://dumpz.org < $ARG | sed 's/http/&s/;s!$!/text/!'
	;;
	w1r3|wire|w1r3.net|w*)
		curl -sF 'upload=@-' https://w1r3.net < $ARG
	;;
	pb|pastebin|pastebin.com)
		[ -z ${PB_API_DEV} ] && usage
		PRIVACY="${PRIVACY:-1}"
		if [ -n "${PRIVACY}" ]; then
			case ${PRIVACY} in
				public|0)
					PRIVACY=0
				;;
				unlisted|1)
					PRIVACY=1
				;;
				private|2)
					PRIVACY=2
				;;
				*)
					usage
				;;
			esac
		fi
		qs="api_option=paste&api_dev_key=${PB_API_DEV}&api_paste_expire_date=N&api_paste_private=${PRIVACY}&api_paste_name=`basename ${ARG}`"
		[ -n ${PB_API_USR} ] && [ -z ${ANON} ] && qs="${qs}&api_user_key=${PB_API_USR}"
		curl -A "$UA" -d "${qs}" --data-urlencode "api_paste_code=`<$ARG`" http://pastebin.com/api/api_post.php
	;;
	*)
		usage
	;;
esac
# vi:syntax=sh
