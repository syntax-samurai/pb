#!/bin/bash

# pb; command line pastebin service helper
# {kopimi,CC0} MMXVIII-MMXXIV . syntax samurai
#         ▟▙
# ▟▒░░░░░░░▜▙▜████████████████████████████████▛
# ▜▒░░░░░░░▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
#         ▜▛
# authors:
#   xero  <https://x-e.ro>
#   stark <https://git.io/stark>
# code:
#   https://code.x-e.ro/pb
#   https://git.io/pb.sh
# greetz:
#   all the ops of these great free services <3

usage() {
	cat <<EOF

     █
▄▀▀▄ █▐▀▄
█▐░█░█▐░█░ ░ ░
█▐▄▀ ▀▄▄▀
█  pb; command line pastebin service helper

usage:
   pb <service> [file|stream]

services:
   0x0.st, catbox.moe, clbin.com, ix.io, lewd.se, p.iotek.org, pastebin.com, temp.sh, uguu.se

environment variables:
   UA: user-agent string (defaults to some chrome one)

envs for pastebin.com:
   PB_API_DEV: developer api key [required] https://pastebin.com/api#1
   PB_API_USR: user api key [optional] https://pastebin.com/api#8
   PRIVACY: paste visibility  [optional] valid values: public|0, unlisted|1, private|2
   ANON: paste w/o a user key even if defined [optional]

examples:
   pb 0x0 ~/.vimrc
   pb clbin <(ps aux)
   dmesg | pb iop
   PB_API_DEV=XXXX PRIVACY=0 pb pb /tmp/leak.txt
   UA="Mozilla/5.0 (PlayStation 4 5.55) AppleWebKit/601.2 (KHTML, like Gecko)" pb uguu /tmp/waifu.jpg

EOF
	exit 0
}

ARG="${2:-/dev/stdin}"
UA=${UA:="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"}

case $1 in
temp | tmp | temp.sh)
	curl -A "$UA" -sF 'file=@-' https://temp.sh/upload <"$ARG"
	;;
ix | ix.io)
	curl -A "$UA" -sF 'f:1=<-' http://ix.io <"$ARG"
	;;
0x0 | null | nullbyte | 0*)
	curl -A "$UA" -sF 'file=@-' https://0x0.st <"$ARG"
	;;
iotek | iopaste | p.iotek.org | iop*)
	curl -A "$UA" -sT- https://p.iotek.org <"$ARG"
	;;
clbin | clbin.com | cl*)
	curl -A "$UA" -sF 'clbin=<-' https://clbin.com <"$ARG"
	;;
uguu | uguu.se | u*)
	curl -A "$UA" -sF 'files[]=@-' https://uguu.se/upload?output=text <"$ARG"
	;;
catbox | catbox.moe | cat*)
	curl -A "$UA" -sF 'reqtype=fileupload' -F 'fileToUpload=@-' https://catbox.moe/user/api.php <"$ARG"
	;;
lewd | lewd.se | l*)
	curl -A "$UA" -sF 'file=@-' https://lewd.se/api.php?d=upload-tool <"$ARG"
	;;
pb | pastebin | pastebin.com)
	[[ -z ${PB_API_DEV} ]] && usage
	PRIVACY="${PRIVACY:-1}"
	if [ -n "${PRIVACY}" ]; then
		case ${PRIVACY} in
		public | 0)
			PRIVACY=0
			;;
		unlisted | 1)
			PRIVACY=1
			;;
		private | 2)
			PRIVACY=2
			;;
		*)
			usage
			;;
		esac
	fi
	qs="api_option=paste&api_dev_key=${PB_API_DEV}&api_paste_expire_date=N&api_paste_private=${PRIVACY}&api_paste_name=$(basename ${ARG})"
	[[ -n ${PB_API_USR} ]] && [[ -z ${ANON} ]] && qs="${qs}&api_user_key=${PB_API_USR}"
	curl -A "$UA" -d "${qs}" --data-urlencode "api_paste_code=$(<"$ARG")" https://pastebin.com/api/api_post.php
	;;
*)
	usage
	;;
esac
# vi:syntax=sh
