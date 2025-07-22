# Firefox Installer
 Install any version of firefox from Mozilla.org

![firefox versions installed image](https://github.com/tmiland/Firefox-Installer/blob/main/img/firefox_versions_installed.png?raw=true)

## Installation

```bash
curl -sSL https://github.com/tmiland/Firefox-Installer/raw/refs/heads/main/firefox_installer.sh > firefox_installer.sh && \
chmod +x firefox_installer.sh
```

## Prerequisites

 - curl (will be installed)
 - packages that will be installed if using mozilla builds:
```bash
menu libasound2 libatk1.0-0 libc6 libcairo-gobject2 libcairo2 libdbus-1-3 libfontconfig1 libfreetype6 libgcc1 libgdk-pixbuf2.0-0 libgdk-pixbuf-2.0-0 libglib2.0-0 libgtk-3-0 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb-shm0 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1
```

 ## Usage:
 
```bash
 firefox_installer.sh [options]

 --help                 |-h   display this help and exit
 --firefox              |-f   latest
 --esr                  |-e   esr
 --beta                 |-b   beta
 --nightly              |-n   nightly
 --devedition           |-d   devedition
 --release              |-rl  select custom release to install*
 --repo                 |-r   install Mozilla APT repo (debian)
 --language             |-l   install language pack (apt)
 --apt                  |-a   select apt install mode
 --mozilla-builds       |-m   select mozilla builds install mode
 --backup-profile       |-bp  backup firefox profile
 --uninstall            |-u   uninstall firefox

 install from apt:            [-f|-e|-b|-n|-d] -a
 install from mozilla builds: [-f|-e|-b|-n|-d] -m
 uninstall:                   [-f|-e|-b|-n|-d], [-a|-m] -u
 * custom release for mozilla builds only [-rl <release>]
```

## Donations
<a href="https://coindrop.to/tmiland" target="_blank"><img src="https://coindrop.to/embed-button.png" style="border-radius: 10px; height: 57px !important;width: 229px !important;" alt="Coindrop.to me"></img></a>

#### Disclaimer 

*** ***Use at own risk*** ***

### License

[![MIT License Image](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/MIT_logo.svg/220px-MIT_logo.svg.png)](https://github.com/tmiland/Firefox-Installer/blob/main/LICENSE)

[MIT License](https://github.com/tmiland/Firefox-Installer/blob/main/LICENSE)