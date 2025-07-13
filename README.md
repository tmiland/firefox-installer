# Firefox Installer
 Install any version of firefox from Mozilla.org

## Installation

```bash
curl -sSL https://github.com/tmiland/Firefox-Installer/raw/refs/heads/main/firefox_installer.sh > firefox_installer.sh && \
chmod +x firefox_installer.sh
```

 ## Usage:
 
```bash
 firefox-installer.sh [options]

 --help                 |-h   display this help and exit
 --firefox              |-f   latest
 --esr                  |-e   esr
 --beta                 |-b   beta
 --nightly              |-n   nightly
 --devedition           |-d   devedition
 --repo                 |-r   install Mozilla APT repo (debian)
 --language             |-l   install language pack (apt)
 --apt                  |-a   select apt install mode
 --mozilla-builds       |-m   select mozilla builds install mode
 --uninstall            |-u   uninstall firefox
 
 - To install firefox from apt, use -f and -a in combination.
 - To uninstall use -f, -a and -u in combination.

 - To install firefox from mozilla builds, use -f and -s in combination.
 - To uninstall use -f, -s and -u in combination.
```

## Donations
<a href="https://coindrop.to/tmiland" target="_blank"><img src="https://coindrop.to/embed-button.png" style="border-radius: 10px; height: 57px !important;width: 229px !important;" alt="Coindrop.to me"></img></a>

#### Disclaimer 

*** ***Use at own risk*** ***

### License

[![MIT License Image](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/MIT_logo.svg/220px-MIT_logo.svg.png)](https://github.com/tmiland/Firefox-Installer/blob/main/LICENSE)

[MIT License](https://github.com/tmiland/Firefox-Installer/blob/main/LICENSE)