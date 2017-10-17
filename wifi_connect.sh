#!/system/bin/sh
ssid=$1
password=$2
ip link set wlan0 down
ip link set wlan0 up
setprop ctl.start wpa_supplicant
wpa_cli -p /data/misc/wifi/sockets/ -i wlan0 <<EOF
flush
scan
scan_results
ping
add_network
set_network 0 ssid "$ssid"
set_network 0 psk "$password"
enable_network 0
select_network 0
quit
EOF
dhcpcd wlan0
ndc resolver setnetdns 0 qian `getprop dhcp.wlan0.dns1`
ip a show wlan0

