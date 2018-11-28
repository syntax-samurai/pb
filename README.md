# pb

```
          █
     ▄▀▀▄ █▐▀▄
░ ░ ░█▐░█░█▐░█░ ░ ░
     █▐▄▀ ▀▄▄▀
     █

 pb; a command line pastebin service helper
    {kopimi,CC0} MMXVIII . syntax samurai

         ▟▙
 ▟▒░░░░░░░▜▙▜████████████████████████████████▛
 ▜▒░░░░░░░▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
         ▜▛
```

## cred

- authors:
	- xero  <https://xero.nu>
	- stark <https://git.io/stark>
- code:
	- https://code.xero.nu/pb
	- https://git.io/pb.sh
- greets:
	- all the ops of these great free services `<3`

## usage

`pb <service> [file|stream]`

# services

- [ix.io](http://ix.io)
- [0x0.st](https://0x0.st)
- [sprunge.us](http://sprunge.us)
- [p.iotek.org](https://p.iotek.org)
- [clbin.com](https://clbin.com)
- [uguu.se](https://uguu.se)
- [lewd.se](https://lewd.se)
- [fiery.me](https://fiery.me)
- [doko.me](https://doko.me)
- [mixtape.moe](https://mixtape.moe)
- [pomf.cat](https://pomf.cat)
- [catbox.moe](https://catbox.moe)
- [asis.io](https://asis.io)
- [dmca.gripe](https://dmca.gripe)
- [ptpb.pw](https://ptpb.pw)
- [rokket.space](https://rokket.space)
- [dumpz.org](https://dumpz.org)
- [n33r.tk](https://n33r.tk)
- [pastebin.com](https://pastebin.com)

## environment variables for pastebin.com:

- `PB_API_DEV`
	- developer api key [required] https://pastebin.com/api#1
- `PB_API_USR`
	- user api key [optional] https://pastebin.com/api#8
- `PRIVACY`
	- paste visibility [optional]
	- valid values: public|0, unlisted|1, private|2
- `ANON`
	- paste w/o a user key even if defined [optional]

## examples

- `pb ix ~/.vimrc`
	- http://ix.io/1lmr
- `pb 0x0 <(ps aux)`
	- https://0x0.st/s0yS.txt
- `dmesg | pb iop`
	- https://p.iotek.org/gb2
- `PB_API_DEV=XXXX PRIVACY=0 pb pb /tmp/leak.txt`
	- https://pastebin.com/ri2QUGCy

## license

![kopimi logo](https://gist.githubusercontent.com/xero/cbcd5c38b695004c848b73e5c1c0c779/raw/6b32899b0af238b17383d7a878a69a076139e72d/kopimi-sm.png)

[kopimi](https://kopimi.com)! in the spirit of _freedom of information_, i encourage you to fork, modify, change, share, or do whatever you like with this project! `^c^v`. or [CC0/public domain](https://creativecommons.org/publicdomain/zero/1.0/) for you nonbelievers. 

