#!/bin/bash
#Autoscript-Lite By RyukillerZ
clear
domain=$(cat /usr/local/etc/xray/domain)
MYIP2=$(wget -qO- ipv4.icanhazip.com);
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\E[0;41;36m  Add XRAY Vless TCP XTLS Account  \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\E[0;41;36m  Add XRAY Vless TCP XTLS Account  \E[0m"
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			menu
		fi
	done

read -p "Bug Address (Example: www.google.com) : " address
read -p "Bug SNI/Host (Example : m.facebook.com) : " hst
read -p "Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=${address}
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
bug=${hst}
bug2=bug.com
if [[ $hst == "" ]]; then
sni=$bug2
else
sni=$bug
fi

uuid=$(cat /proc/sys/kernel/random/uuid)
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`

# // Input To Server
sed -i '/#xtls$/a\#! '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /usr/local/etc/xray/config.json

vless_direct1="vless://${uuid}@${sts}${domain}:443?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${sni}#XRAY_VLESS_DIRECT_$user"
vless_direct2="vless://${uuid}@${sts}${domain}:443?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct-udp443&sni=${sni}#XRAY_VLESS_DIRECTUDP443_$user"
vless_splice3="vless://${uuid}@${sts}${domain}:443?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${sni}#XRAY_VLESS_SPLICE_$user"
vless_splice4="vless://${uuid}@${sts}${domain}:443?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice-udp443&sni=${sni}#XRAY_VLESS_SPLICEUDP443_$user"

# // Restarting Service
systemctl restart xray.service
service cron restart

cat > /home/vps/public_html/$user-VLESSDIRECT.yaml <<EOF
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: XRAY_VLESS_DIRECT_${user}
    server: ${sts}${domain}
    port: 443
    type: vless
    uuid: ${uuid}
    cipher: auto
    tls: true
    flow: xtls-rprx-direct
    skip-cert-verify: true
    servername: ${sni}
    udp: true
proxy-groups:
  - name: RyukillerZ-AUTOSCRIPT
    type: select
    proxies:
      - XRAY_VLESS_DIRECT_${user}
      - DIRECT
rules:
  - MATCH,RyukillerZ-AUTOSCRIPT
EOF

cat > /home/vps/public_html/$user-VLESSSPLICE.yaml <<EOF
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: XRAY_VLESS_SPLICE_${user}
    server: ${sts}${domain}
    port: 443
    type: vless
    uuid: ${uuid}
    cipher: auto
    tls: true
    flow: xtls-rprx-splice
    skip-cert-verify: true
    servername: ${sni}
    udp: true
proxy-groups:
  - name: RyukillerZ-AUTOSCRIPT
    type: select
    proxies:
      - XRAY_VLESS_SPLICE_${user}
      - DIRECT
rules:
  - MATCH,RyukillerZ-AUTOSCRIPT
EOF

clear
echo -e "" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "════════════[XRAY VLESS TCP XTLS]════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Remarks              : ${user}" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Domain               : ${domain}" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "ID                   : ${uuid}" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Port Direct          : 443" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Port Splice          : 443" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Encryption           : None" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Network              : TCP" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Security             : XTLS" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Flow                 : Direct & Splice" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "AllowInsecure        : True/Allow" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Link Direct          : ${vless_direct1}" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Link Direct UDP 443  : ${vless_direct2}" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Link Splice          : ${vless_splice3}" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Link Splice UDP 443  : ${vless_splice4}" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "YAML Direct          : http://${MYIP2}:81/$user-VLESSDIRECT.yaml" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "YAML Splice          : http://${MYIP2}:81/$user-VLESSSPLICE.yaml" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Created On           : $hariini" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Expired On           : $exp" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "═════════════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "Autoscript By RyukillerZ" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
echo -e "" | tee -a /usr/local/etc/xray/configlogs/vlessxtls-$user.txt