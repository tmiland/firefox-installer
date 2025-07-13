#!/usr/bin/env bash
# shellcheck disable=SC2140,SC2206,SC2068,SC2181

## Author: Tommy Miland (@tmiland) - Copyright (c) 2025


######################################################################
####                    firefox_installer.sh                      ####
####                     Firefox Installer                        ####
####        Install any version of firefox from Mozilla.org       ####
####                   Maintained by @tmiland                     ####
######################################################################

# VERSION='1.0.0' # Must stay on line 14 for updater to fetch the numbers

#------------------------------------------------------------------------------#
#
# MIT License
#
# Copyright (c) 2025 Tommy Miland
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#------------------------------------------------------------------------------#
# Symlink: ln -sfn ~/.scripts/swa.sh ~/.local/bin/swa
## For debugging purpose
if [[ $* =~ "debug" ]]
then
  set -o errexit
  set -o pipefail
  set -o nounset
  set -o xtrace
fi
# Get script filename
self=$(readlink -f "${BASH_SOURCE[0]}")
SCRIPT_FILENAME=$(basename "$self")
keyrings=/etc/apt/keyrings
FIREFOX_VER_NAME=${FIREFOX_VER_NAME:-firefox}
FIREFOX_LANG=${FIREFOX_LANG:-en-US}
FIREFOX_INSTALL_DIR=/opt

shopt -s nocasematch
if [[ -f /etc/debian_version ]]; then
  DISTRO=Debian
fi

shopt -s nocasematch
if [[ $DISTRO == "Debian" ]]; then
  export DEBIAN_FRONTEND=noninteractive
else
  echo -e "Error: Sorry, your OS is not supported."
  exit 1;
fi

ARCH=$(uname -m)

case "$ARCH" in
  x86_64)
    ARCH=linux64
  ;;
  i686)
    ARCH=linux
  ;;
esac

mozilla_url=https://download.mozilla.org

lang_array=(
  "English (US)               lang=en-US"
  "Acholi                     lang=ach"
  "Afrikaans                  lang=af"
  "Albanian                   lang=sq"
  "Arabic                     lang=ar"
  "Aragonese                  lang=an"
  "Armenian                   lang=hy-AM"
  "Assamese                   lang=as"
  "Asturian                   lang=ast"
  "Azerbaijani                lang=az"
  "Basque                     lang=eu"
  "Belarusian                 lang=be"
  "Bengali (Bangladesh)       lang=bn-BD"
  "Bengali (India)            lang=bn-IN"
  "Bosnian                    lang=bs"
  "Breton                     lang=br"
  "Bulgarian                  lang=bg"
  "Catalan                    lang=ca"
  "Chinese (Simplified)       lang=zh-CN"
  "Chinese (Traditional)      lang=zh-TW"
  "Croatian                   lang=hr"
  "Czech                      lang=cs"
  "Danish                     lang=da"
  "Dutch                      lang=nl"
  "English (British)          lang=en-GB"
  "English (South African)    lang=en-ZA"
  "Esperanto                  lang=eo"
  "Estonian                   lang=et"
  "Finnish                    lang=fi"
  "French                     lang=fr"
  "Frisian                    lang=fy-NL"
  "Fulah                      lang=ff"
  "Gaelic (Scotland)          lang=gd"
  "Galician                   lang=gl"
  "German                     lang=de"
  "Greek                      lang=el"
  "Gujarati (India)           lang=gu-IN"
  "Hebrew                     lang=he"
  "Hindi (India)              lang=hi-IN"
  "Hungarian                  lang=hu"
  "Icelandic                  lang=is"
  "Indonesian                 lang=id"
  "Irish                      lang=ga-IE"
  "Italian                    lang=it"
  "Kannada                    lang=kn"
  "Kazakh                     lang=kk"
  "Khmer                      lang=km"
  "Korean                     lang=ko"
  "Latvian                    lang=lv"
  "Ligurian                   lang=lij"
  "Lithuanian                 lang=lt"
  "Lower Sorbian              lang=dsb"
  "Macedonian                 lang=mk"
  "Malay                      lang=ms"
  "Maithili                   lang=mai"
  "Malayalam                  lang=ml"
  "Marathi                    lang=mr"
  "Norwegian (Bokmål)         lang=nb-NO"
  "Norwegian (Nynorsk)        lang=nn-NO"
  "Oriya                      lang=or"
  "Persian                    lang=fa"
  "Polish                     lang=pl"
  "Portuguese (Brazilian)     lang=pt-BR"
  "Portuguese (Portugal)      lang=pt-PT"
  "Punjabi (India)            lang=pa-IN"
  "Romanian                   lang=ro"
  "Romansh                    lang=rm"
  "Russian                    lang=ru"
  "Serbian                    lang=sr"
  "Sinhala                    lang=si"
  "Slovak                     lang=sk"
  "Slovenian                  lang=sl"
  "Songhai                    lang=son"
  "Spanish (Argentina)        lang=es-AR"
  "Spanish (Chile)            lang=es-CL"
  "Spanish (Mexico)           lang=es-MX"
  "Spanish (Spain)            lang=es-ES"
  "Swedish                    lang=sv-SE"
  "Tamil                      lang=ta"
  "Telugu                     lang=te"
  "Thai                       lang=th"
  "Turkish                    lang=tr"
  "Ukrainian                  lang=uk"
  "Upper Sorbian              lang=hsb"
  "Uzbek                      lang=uz"
  "Vietnamese                 lang=viv"
  "Welsh                      lang=cy"
  "Xhosa                      lang=xh"
)

install_firefox_repo() {
  if [ ! -d $keyrings ]; then
    sudo install -d -m 0755 $keyrings
  fi
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- |
  sudo tee $keyrings/packages.mozilla.org.asc > /dev/null
  key_fingerprint=35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3
  if gpg -n -q --import --import-options import-show $keyrings/packages.mozilla.org.asc | grep "$key_fingerprint" > /dev/null
  then
    echo "The key fingerprint matches ($key_fingerprint)."
  else
    echo "Verification failed: the fingerprint ($key_fingerprint) does not match the expected one."
    exit 0
  fi
  echo "deb [signed-by=$keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" |
  sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
  echo '
      Package: *
      Pin: origin packages.mozilla.org
      Pin-Priority: 1000
  ' | sudo tee /etc/apt/preferences.d/mozilla
}

install_firefox() {
  if [ "$mode" != "uninstall" ]; then
    if [ "$mode" == "apt" ]; then
      if [ ! -f /etc/apt/sources.list.d/mozilla.list  ]; then
        install_firefox_repo
      fi
      sudo apt-get -o Dpkg::Progress-Fancy="1" update &&
      sudo apt-get -o Dpkg::Progress-Fancy="1" install "$FIREFOX_VER_NAME"
    fi
    if [ "$mode" == "mozilla" ]; then
      language=("${lang_array[@]}")
      read -rp "$(
            f=0
            for l in "${language[@]}" ; do
                    echo "$((++f)): $l"
            done
            echo -ne "Please select a language: "
      )" selection
      selected_language="${language[$((selection-1))]}"
      FIREFOX_LANG=$(echo "$selected_language" | grep -o "lang=.*" | sed "s|lang=||g")
      language_selected=$(echo "$selected_language" | grep -o ".* lang=" | sed "s|lang=||g")
      
      echo "You selected $language_selected"
      echo "Installing $FIREFOX_VER_NAME to $FIREFOX_INSTALL_DIR"
      firefox_url="$mozilla_url/?product=$FIREFOX_VER_NAME-latest-ssl&os=$ARCH&lang=$FIREFOX_LANG"
      sudo apt-get install libasound2 libatk1.0-0 libc6 libcairo-gobject2 libcairo2 libdbus-1-3 libfontconfig1 libfreetype6 libgcc1 libgdk-pixbuf2.0-0 libgdk-pixbuf-2.0-0 libglib2.0-0 libgtk-3-0 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb-shm0 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 >/dev/null 2>&1
      cd /tmp || exit 0
      sudo wget -O "$FIREFOX_VER_NAME".tar.xz -q "$firefox_url"
      sudo tar -xf "$FIREFOX_VER_NAME".tar.xz
      sudo mv firefox "$FIREFOX_INSTALL_DIR"/"$FIREFOX_VER_NAME" >/dev/null 2>&1
      sudo ln -snf "$FIREFOX_INSTALL_DIR"/"$FIREFOX_VER_NAME"/firefox /usr/local/bin/"$FIREFOX_VER_NAME"
      echo "[Desktop Entry]
Version=1.0
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/$FIREFOX_VER_NAME/browser/chrome/icons/default/default128.png
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true" | sudo tee /usr/local/share/applications/"$FIREFOX_VER_NAME".desktop >/dev/null 2>&1
      sudo rm "$FIREFOX_VER_NAME".tar.xz
      if [ $? -eq 0 ]; then
          echo "Done."
      else
        echo "Installing $FIREFOX_VER_NAME to $FIREFOX_INSTALL_DIR FAILED."
      fi
      cd - >/dev/null 2>&1 || exit 0
    fi
  fi
}

uninstall_firefox() {
  if [ "$mode" == "apt" ]; then
    sudo apt-get -o Dpkg::Progress-Fancy="1" uninstall "$FIREFOX_VER_NAME"
    sudo rm /etc/apt/sources.list.d/mozilla.list
    sudo rm $keyrings/packages.mozilla.org.asc
    sudo rm /etc/apt/preferences.d/mozilla
    sudo apt-get -o Dpkg::Progress-Fancy="1" update
  fi
  if [ "$mode" == "mozilla" ]; then
    echo "Deleting files for $FIREFOX_VER_NAME"
    sudo rm /usr/local/share/applications/"$FIREFOX_VER_NAME".desktop
    sudo rm /usr/local/bin/"$FIREFOX_VER_NAME"
    sudo rm -rf /opt/"$FIREFOX_VER_NAME"
    echo "Done."
  fi
}

install_language() {
  if [ "$mode" == "apt" ]; then
    language_array=$(apt-cache search firefox-l10n | sed "s|- Mozilla Firefox -.*||g")
    language=($language_array)

    read -rp "$(
          f=0
          for d in ${language[@]} ; do
                  echo "$((++f)): $d"
          done
          echo -ne "Please select a language : "
    )" selection
    selected_language="${language[$((selection-1))]}"
    echo "You selected $selected_language"
    sudo "${INSTALL}" "$selected_language"
  fi
}

usage() {
  #header
  ## shellcheck disable=SC2046
  printf "Usage: %s [options]" "${SCRIPT_FILENAME}"
  echo
  echo
  cat <<EOF
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
EOF
  echo
}

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --help | -h)
      usage
      exit 0
      ;;
    --firefox | -f)
      shift
      # FIREFOX_VER=$STABLE_VER
      FIREFOX_VER_NAME=firefox
      ;;
    --esr | -e)
      shift
      # FIREFOX_VER=$MAINLINE_VER
      FIREFOX_VER_NAME=firefox-esr
      ;;
    --beta | -b)
      shift
      # FIREFOX_VER="$2"
      FIREFOX_VER_NAME=firefox-beta
      ;;
    --nightly | -n)
      shift
      # FIREFOX_VER="$2"
      FIREFOX_VER_NAME=firefox-nightly
      ;;
    --devedition | -d)
      shift
      # FIREFOX_VER="$2"
      FIREFOX_VER_NAME=firefox-devedition
      ;;
    --repo | -r)
      shift
      install_firefox_repo
      ;;
    --language | -l)
      shift
      install_language
      ;;
    --apt | -a)
      shift
      mode="apt"
      ;;
    --mozilla-builds | -m)
      shift
      mode="mozilla"
      ;;
    --uninstall | -u)
      shift
      uninstall_firefox
      mode="uninstall"
      ;;
    --* | -*)
      printf "%s\\n\\n" "Unrecognized option: $1"
      usage
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if ! install_firefox; then
  echo "firefox installation returned an error."
fi