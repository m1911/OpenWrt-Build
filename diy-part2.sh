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
#sed -i 's/192.168/10.0/g' package/base-files/files/bin/config_generate
sed -i 's/0.0.0.0:80/0.0.0.0:8088/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/\[::\]:80/\[::\]:8088/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/0.0.0.0:443/0.0.0.0:8443/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/\[::\]:443/\[::\]:8443/g' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/root::0:0:99999:7:::/root:\$1\$YGNTInHx\$ia4X7RK0t2muvsAk1P\/cu0:18513:0:99999:7:::/g' package/base-files/files/etc/shadow
sed -i '20s/REJECT/ACCEPT/g' package/network/config/firewall/files/firewall.config
cat >> package/network/config/firewall/files/firewall.config<< EOF

config rule
        option src 'wan'
        option target 'ACCEPT'
        option proto 'tcp'
        option dest_port '8088'
        option name 'httpdwan'

config rule
        option name 'http80'
        option src 'wan'
        option src_port '80'
        option dest 'lan'
        list dest_ip '192.168.18.1'
        option dest_port '80'
        option target 'ACCEPT'

config rule
        option name 'http443'
        option src 'wan'
        option src_port '443'
        option dest 'lan'
        list dest_ip '192.168.18.1'
        option dest_port '443'
        option target 'ACCEPT'
EOF
cat >> package/base-files/files/etc/sysctl.conf<< EOF
net.netfilter.nf_conntrack_max=65535
EOF

