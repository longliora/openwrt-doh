#!/bin/sh

find_next_id() {
    local input_id="$1"
    local next_id=""
    local nextdns_ids="/opt/nextdns/nextdns_ids.txt"
    line_number=$(grep -n "$input_id" "$nextdns_ids" | cut -d ':' -f 1)
    expr "$line_number" + 0 >/dev/null 2>&1
    if ! [ $? -eq 0 ]; then
        line_number=0
    fi
    next_line=$((line_number % $(wc -l < "$nextdns_ids") + 1))
    next_id=$(sed -n "${next_line}p" "$nextdns_ids")
    echo "$next_id"
}

config_file=$(cat /etc/config/https-dns-proxy)
current_id="${config_file#*nextdns\.io/}"; current_id="${current_id%%/*}"
next_id=$(find_next_id "$current_id")
echo "Change NextDNS from [$current_id] to [$next_id]"
logger -t NextDNS "Change NextDNS from [$current_id] to [$next_id]"

while uci -q delete https-dns-proxy.@https-dns-proxy[0]; do :; done
uci set https-dns-proxy.config.force_dns="0"
uci add https-dns-proxy https-dns-proxy > /dev/null
uci set https-dns-proxy.@https-dns-proxy[-1].resolver_url="https://dns1.nextdns.io/$next_id/OpenWrt"
uci set https-dns-proxy.@https-dns-proxy[-1].bootstrap_dns="8.8.8.8,1.1.1.1"
uci set https-dns-proxy.@https-dns-proxy[-1].listen_addr="127.0.0.1"
uci set https-dns-proxy.@https-dns-proxy[-1].listen_port="5053"
uci add https-dns-proxy https-dns-proxy > /dev/null
uci set https-dns-proxy.@https-dns-proxy[-1].resolver_url="https://dns2.nextdns.io/$next_id/OpenWrt"
uci set https-dns-proxy.@https-dns-proxy[-1].bootstrap_dns="8.8.8.8,1.1.1.1"
uci set https-dns-proxy.@https-dns-proxy[-1].listen_addr="127.0.0.1"
uci set https-dns-proxy.@https-dns-proxy[-1].listen_port="5054"
uci commit https-dns-proxy
/etc/init.d/https-dns-proxy restart
