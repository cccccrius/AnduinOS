#!/bin/bash

# on met le clavier fr seulement
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fr')]"

# on supprime le repo firefox chinois
sudo \rm /etc/apt/preferences.d/mozilla-firefox
sudo \rm /etc/apt/sources.list.d/mozillateam-*

# on met les serveurs français pour apt
echo "deb http://fr.archive.ubuntu.com/ubuntu/ plucky main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu/ plucky-updates main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu/ plucky-backports main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu/ plucky-security main restricted universe multiverse" | sudo tee /etc/apt/sources.list

# on supprime firefox installé depuis le repo chinois
sudo apt purge -y firefox*

# on impoorte la clé du repo officiel mozilla
sudo wget https://packages.mozilla.org/apt/repo-signing-key.gpg -O  /etc/apt/keyrings/packages.mozilla.org.asc

# on crée le repo officiel mozilla
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list

# on autorise à installer firefox que depuis le repo mozilla
echo "Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000" | sudo tee /etc/apt/preferences.d/firefox-deb-nosnap

# mise à jour apt
sudo apt update

# on installe firefox:
sudo apt install -y firefox-l10n-fr

# on configure firefox
sudo \rm /usr/lib/firefox/defaults/pref/autoconfig.js 2> /dev/null
sudo mkdir -p /usr/lib/firefox/defaults/pref/ 2> /dev/null
sudo tee /usr/lib/firefox/defaults/pref/autoconfig.js >/dev/null <<'EOF'
//
pref("general.config.sandbox_enabled", false);
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF

sudo \rm /usr/lib/firefox/firefox.cfg 2> /dev/null
sudo tee /usr/lib/firefox/firefox.cfg >/dev/null <<'EOF'
//the first line is always a comment
pref("network.trr.mode", 3);
pref("network.trr.uri", "https://dns.nextdns.io/c8d79a");
pref("network.trr.custom_uri", "https://dns.nextdns.io/c8d79a");
pref("network.trr.bootstrapAddress", "45.90.28.181");
pref("network.trr.default_provider_uri", "https://dns.nextdns.io/c8d79a");
pref("extensions.autoDisableScopes", 0);
pref("browser.aboutConfig.showWarning", false);
pref("browser.startup.homepage", "https://www.google.fr");
pref("startup.homepage_welcome_url", "https://www.google.fr");
pref("startup.homepage_override_url", "https://www.google.fr");
pref("browser.shell.checkDefaultBrowser", false);
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
pref("app.update.silent", true);
pref("browser.messaging-system.whatsNewPanel.enabled", false);
pref("privacy.trackingprotection.enabled", true);
pref("privacy.firstparty.isolate", true);
pref("privacy.donottrackheader.enabled", true);
pref("privacy.globalprivacycontrol.enabled", true);
pref("privacy.globalprivacycontrol.functionality.enabled", true);
pref("toolkit.telemetry.archive.enabled", false);
pref("toolkit.telemetry.enabled", false);
pref("toolkit.telemetry.rejected", true);
pref("toolkit.telemetry.unified", false);
pref("toolkit.telemetry.unifiedIsOptIn", false);
pref("toolkit.telemetry.prompted", 2);
pref("toolkit.telemetry.rejected", true);
pref("datareporting.policy.dataSubmissionEnabled", false);
pref("datareporting.healthreport.service.enabled", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("app.shield.optoutstudies.enabled", false);
pref("browser.urlbar.suggest.pocket", false);
pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
pref("browser.newtabpage.activity-stream.system.showSponsored", false);
pref("browser.newtabpage.activity-stream.showSponsored", false);
pref("extensions.pocket.enabled", false);
pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
pref("network.dns.echconfig.enabled", true);
pref("network.dns.http3_echconfig.enabled", true);
pref("browser.toolbars.bookmarks.visibility", "always");
pref("media.ffmpeg.vaapi.enabled",true);
pref("media.ffvpx.enabled",false);
pref("media.rdd-vpx.enabled",false);
pref("media.navigator.mediadatadecoder_vpx_enabled",true);
pref("sidebar.visibility", "hide-sidebar");
pref("sidebar.revamp", false);
EOF

sudo \rm /usr/lib/firefox/distribution/policies.json 2> /dev/null
sudo mkdir -p /usr/lib/firefox/distribution 2> /dev/null
#about:memory -> measure
sudo tee /usr/lib/firefox/distribution/policies.json >/dev/null <<'EOF'
{
  "policies": {
    "ExtensionSettings": {
      "uBlock0@raymondhill.net": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      },
      "{26b743a8-b1b0-4b8c-a51e-0fc3797727a8}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-consent-dialog-remover/latest.xpi"
      },
      "DontFuckWithPaste@raim.ist": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi"
      },
      "jid1-MnnxcxisBPnSXQ@jetpack": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi"
      },
      "newtaboverride@agenedia.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi"
      },
      "pure-url@jetpack": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/pure-url/latest.xpi"
      },
      "gdpr@cavi.au.dk": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi"
      },
      "magnolia_limited_permissions@12.34": {
        "installation_mode": "normal_installed",
        "install_url": "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-3.8.8.0-custom.xpi"
      },
      "{74145f27-f039-47ce-a470-a662b129930a}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
      },
      "dont-track-me-google@robwu.nl": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/dont-track-me-google1/latest.xpi"
      },
      "gmailellcheckersimple@durasoft": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/gmail-checker-simple/latest.xpi"
      },
      "{abea9bb3-7bd0-48bc-88b1-39f0560744d6}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-search-fixer-refreshed/latest.xpi"
      },
      "{00000f2a-7cde-4f20-83ed-434fcb420d71}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi"
      },
      "support@netflux.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/netflux/latest.xpi"
      },
      "plasma-browser-integration@kde.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi"
      },
      "chrome-gnome-shell@gnome.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/gnome-shell-integration/latest.xpi"
      },
      "{7c73b62b-7ac7-4292-81a7-c15746af0972}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-search-display-icon/latest.xpi"
      },
      "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi"
      },
      "NetflixPrime@Autoskip.io": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/netflix-prime-auto-skip/latest.xpi"
      },
      "78272b6fa58f4a1abaac99321d503a20@proton.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi"
      }
    }
  }
}
EOF

# installation du vérificateur de mises à jour gnome
sudo apt install -y gnome-packagekit # ce qui va aussi installer gnome-package-updater et gnome-packagekit-common*

# installation only office repo
mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg
echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list

# installation des logiciels
sudo apt install -y onlyoffice-desktopeditors vlc-l10n vlc gnome-shell-extension-manager pdfsam xournal gnome-tweaks

# icones tela
wget -O /tmp/tela.zip $WGETOPT https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
cd /tmp
sudo \rm -rf /tmp/tela
sudo \rm -rf /tmp/Tela-icon-theme-master
mkdir -p /tmp/tela > /dev/null 2>&1
sudo unzip /tmp/tela.zip -d /tmp/tela > /dev/null 2>&1
cd /tmp/tela/Tela-icon-theme-master
sudo ./install.sh > /dev/null 2>&1

# curseurs breeze
wget -O /tmp/breeze.tar.gz $WGETOPT https://github.com/polirritmico/Breeze-Dark-Cursor/releases/download/v1.0/Breeze_Dark_v1.0.tar.gz
cd /tmp
tar -xf breeze.tar.gz >/dev/null 2>&1
sudo mkdir -p /usr/share/icons/Breeze_Dark/
sudo cp -rf /tmp/Breeze_Dark/* /usr/share/icons/Breeze_Dark/
\rm -rf breeze.tar.gz
sudo chown root:root /usr/share/icons/Breeze_Dark/
sudo chmod -R 755 /usr/share/icons/Breeze_Dark/
sudo dnf install -y breeze-cursor-theme > /dev/null 2>&1

# configuration de gnome
gsettings set org.gnome.desktop.interface icon-theme 'Tela-dark'
#gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_Dark'
gsettings set org.gnome.nautilus.preferences show-delete-permanently true
gsettings set org.gnome.nautilus.preferences show-directory-item-counts 'always'
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
gsettings set org.gnome.nautilus.preferences recursive-search 'always'
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled-on-external-mouse
gsettings set org.gnome.software download-updates true
gsettings set org.gnome.software show-only-free-apps false
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy old-files-age "30"
gsettings set org.gnome.desktop.privacy report-technical-problems false
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'
gsettings set org.gnome.TextEditor highlight-current-line false
gsettings set org.gnome.TextEditor restore-session false
gsettings set org.gnome.TextEditor show-line-numbers true

# raccourcis clavier
BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['$KEY_PATH/custom0/', '$KEY_PATH/custom1/', '$KEY_PATH/custom2/', '$KEY_PATH/custom3/', '$KEY_PATH/custom4/']"

# Take a screenshot of the entire display
$BEGINNING/custom0/ name "Take Full Screenshot"
$BEGINNING/custom0/ command "shutter --full"
$BEGINNING/custom0/ binding "Print"

# screenshot the current active window
$BEGINNING/custom1/ name "Grab Active Window"
$BEGINNING/custom1/ command "shutter --active"
$BEGINNING/custom1/ binding "<Alt>Print"

# Take a selection of screen with screenshot
$BEGINNING/custom2/ name "Screenshot Selection"
$BEGINNING/custom2/ command "shutter --select"
$BEGINNING/custom2/ binding "<Shift>Print"

# Launch Terminal
$BEGINNING/custom3/ name "Gnome Terminal"
$BEGINNING/custom3/ command "gnome-terminal"
$BEGINNING/custom3/ binding "<Super>Q"

# Open up file browser
$BEGINNING/custom4/ name "Nautilus"
$BEGINNING/custom4/ command "/usr/bin/nautilus --new-window"
$BEGINNING/custom4/ binding "<Super>E"
