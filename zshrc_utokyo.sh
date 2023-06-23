# My personal zsh configuration file
# Copyright (C) 2023 conjikidow
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.


function set_utwifi() {
    SSID_UTokyoWiFi="0000UTokyo"
    SSID_eduroam="eduroam"

    echo "Enter the user ID prior to "@" symbol > \c"
    read USER_ID
    echo "Enter the password > \c"
    read PASSWORD

    nmcli connection edit id ${SSID_UTokyoWiFi} << EOF
set ipv4.method auto
set 802-1x.eap peap
set 802-1x.phase2-auth mschapv2
set 802-1x.phase2-ca-cert /usr/share/ca-certificates/mozilla/Security_Communication_RootCA2.crt
set 802-1x.identity ${USER_ID}@wifi.u-tokyo.ac.jp
set 802-1x.password ${PASSWORD}
set wifi-sec.key-mgmt wpa-eap
save
activate
EOF

    nmcli connection edit id ${SSID_eduroam} << EOF
set ipv4.method auto
set 802-1x.eap peap
set 802-1x.phase2-auth mschapv2
set 802-1x.phase2-ca-cert /usr/share/ca-certificates/mozilla/Security_Communication_RootCA2.crt
set 802-1x.identity ${USER_ID}@wifi.u-tokyo.ac.jp
set 802-1x.password ${PASSWORD}
set wifi-sec.key-mgmt wpa-eap
save
EOF
}

function add_utwifi() {
    WIFI_INTERFACE=$(ls /sys/class/net | grep wl)

    SSID_UTokyoWiFi="0000UTokyo"
    SSID_eduroam="eduroam"

    nmcli connection add type wifi ifname ${WIFI_INTERFACE} con-name ${SSID_UTokyoWiFi} ssid ${SSID_UTokyoWiFi}
    nmcli connection add type wifi ifname ${WIFI_INTERFACE} con-name ${SSID_eduroam} ssid ${SSID_eduroam}

    set_utwifi
}
