#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.18.1/g' package/base-files/files/bin/config_generate
sed -i 's/0.0.0.0:80/0.0.0.0:8088/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/[::]:80/[::]:8088/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/0.0.0.0:443/0.0.0.0:8443/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/[::]:443/[::]:8443/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/root::0:0:99999:7:::/root:\$1\$YGNTInHx\$ia4X7RK0t2muvsAk1P\/cu0:18513:0:99999:7:::/g' package/base-files/files/etc/shadow
cat >> package/network/config/firewall/files/firewall.config<< EOF

config rule
        option src 'wan'
        option target 'ACCEPT'
        option proto 'tcp'
        option dest_port '8088'
        option name 'httpdwan'
EOF
#sed -i 's/192.168/10.0/g' package/base-files/files/bin/config_generate
