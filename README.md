# Firefox Installer
 Install any version of firefox from Mozilla.org on Debian based distros

![firefox versions installed image](https://github.com/tmiland/firefox-installer/blob/main/img/firefox_versions_installed.png?raw=true)

Also check out [thunderbird-installer](https://github.com/tmiland/thunderbird-installer)

Currently supported distros:

- Debian
- Ubuntu
- LinuxMint
- PureOS
- Pop
- Devuan

## Installation

```bash
curl -sSL https://tmiland.github.io/firefox-installer/firefox_installer.sh \
     -o firefox_installer.sh && \
     chmod +x firefox_installer.sh && \
     ./firefox_installer.sh -h
```

## Prerequisites

- curl (will be installed)
- packages that will be installed if using mozilla builds:
```bash
menu libasound2 libatk1.0-0 libc6 libcairo-gobject2 libcairo2 libdbus-1-3 libfontconfig1 libfreetype6 libgcc1 libgdk-pixbuf2.0-0 libgdk-pixbuf-2.0-0 libglib2.0-0 libgtk-3-0 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb-shm0 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1
```
- git (if installing mozilla-sync)

## Features
- Download any version of firefox, from Mozilla or package manager (apt)
- Install [Mozilla APT repo](https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions-recommended)
- Install self hosted [Firefox Sync](https://www.firefox.com/en-US/features/sync/) (Docker)
  * **Using dev branch from [tmiland/firefox-sync](https://github.com/tmiland/firefox-sync/tree/dev)**
  * Tested and working with firefox 148.0
- Take backups of your firefox profile

 ## Usage
 
```bash
Usage: firefox_installer.sh [options]

  --help                 |-h   display this help and exit
  --firefox              |-f   latest
  --esr                  |-e   esr
  --beta                 |-b   beta
  --nightly              |-n   nightly
  --devedition           |-d   devedition
  --release              |-rl  select custom release to install*
  --repo                 |-r   install Mozilla APT repo (apt)
  --firefox-sync         |-fs  install firefox-sync (docker)
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

### Install all versions from mozilla builds

```bash
for i in f e b n d; do
  ./firefox_installer.sh -$i -m
done
```

## Credits
- [Mozilla](https://www.mozilla.org/) for [Firefox](https://www.mozilla.org/firefox)
- [porelli/firefox-sync](https://github.com/porelli/firefox-sync) for dockerized mozilla-sync.
- Huge thanks to [Self Hosting A Firefox Sync Server](https://www.bentasker.co.uk/posts/documentation/linux/selfhosting-a-firefox-sync-server.html) for finding a solution to get firefox-sync working.

## Donations
<a href="https://coindrop.to/tmiland" target="_blank"><img src="https://coindrop.to/embed-button.png" style="border-radius: 10px; height: 57px !important;width: 229px !important;" alt="Coindrop.to me"></img></a>

### Disclaimer 

*** ***Use at own risk*** ***

### License

[![MIT License Image](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/MIT_logo_2003-2023.svg/330px-MIT_logo_2003-2023.svg.png?20250128192424)](https://tmiland.github.io/firefox-installer/blob/main/LICENSE)

[MIT License](https://tmiland.github.io/firefox-installer/blob/main/LICENSE)
