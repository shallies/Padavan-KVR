#!/bin/sh
#nvram set ntp_ready=0

mkdir -p /tmp/dnsmasq.dom
logger -t "为防止dnsmasq启动失败，创建/tmp/dnsmasq.dom/"

if [ $(nvram get sdns_enable) = 1 ] ; then
logger -t "自动启动" "正在启动SmartDns ……"
/usr/bin/smartdns.sh start
fi

if [ $(nvram get caddy_enable) = 1 ] ; then
logger -t "自动启动" "正在启动文件管理 ……"
/usr/bin/caddy.sh start
fi

logger -t "自动启动" "正在检查网络连接状态 ……"
server_to_ping=`nvram get di_addr5`
if [ "$server_to_ping" = "" ]; then
	server_to_ping="8.8.8.8"
fi
count=10
while [ $count -gt 0 ];
do
	ping -c 1 -W 1 -q $server_to_ping 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	sleep 1
	ping -c 1 -W 1 -q baidu.com 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	sleep 1
	count=$((count-1))
done

if [ $(nvram get adbyby_enable) = 1 ] ; then
logger -t "自动启动" "正在启动adbyby plus+ ……"
/usr/bin/adbyby.sh start
fi

if [ $(nvram get koolproxy_enable) = 1 ] ; then
logger -t "自动启动" "正在启动koolproxy ……"
/usr/bin/koolproxy.sh start
fi

if [ $(nvram get aliddns_enable) = 1 ] ; then
logger -t "自动启动" "正在启动阿里ddns ……"
/usr/bin/aliddns.sh start
fi

if [ $(nvram get ss_enable) = 1 ] ; then
logger -t "自动启动" "正在启动科学上网 ……"
/usr/bin/shadowsocks.sh start
fi

if [ $(nvram get adg_enable) = 1 ] ; then
logger -t "自动启动" "正在启动adguardhome"
/usr/bin/adguardhome.sh start
fi

if [ $(nvram get wyy_enable) = 1 ] ; then
logger -t "自动启动" "正在启动音乐解锁 ……"
/usr/bin/unblockmusic.sh start
fi

if [ $(nvram get zerotier_enable) = 1 ] ; then
logger -t "自动启动" "正在启动zerotier ……"
/usr/bin/zerotier.sh start
fi

if [ $(nvram get nvpproxy_enable) = 1 ] ; then
logger -t "自动启动" "正在启动nvpproxy ……"
/usr/bin/nvpproxy.sh start
fi

if [ $(nvram get ddnsto_enable) = 1 ] ; then
logger -t "自动启动" "正在启动ddnsto ……"
/usr/bin/ddnsto.sh start
fi

if [ $(nvram get aliyundrive_enable) = 1 ] ; then
logger -t "自动启动" "正在启动阿里云盘 ……"
/usr/bin/aliyundrive-webdav.sh start
fi

if [ $(nvram get wireguard_enable) = 1 ] ; then
logger -t "自动启动" "正在启动wireguard ……"
/usr/bin/wireguard.sh start
fi

if [ $(nvram get vlmcsd_enable) = 1 ] ; then
logger -t "自动启动" "正在启动 vlmcsd ……"
/usr/bin/vlmcsd.sh start &
fi
