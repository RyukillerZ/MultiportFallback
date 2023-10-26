#!/bin/bash
#Autoscript-Lite By RyukillerZ
clear
MYIP2=$(wget -qO- ipv4.icanhazip.com);
domain=$(cat /usr/local/etc/xray/domain)
user=TRIAL-`echo $RANDOM | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#vmtls$/a\#~& '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

cat> /usr/local/etc/xray/$user-tls.json << EOF
      {
      "v": "2",
      "ps": "XRAY_VMESS_TLS_${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess-ws",
      "type": "none",
      "host": "${domain}",
      "tls": "tls",
      "sni": "${domain}"
}
EOF

cat> /usr/local/etc/xray/$user-none.json << EOF
      {
      "v": "2",
      "ps": "XRAY_VMESS_NON_TLS_${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess-ws",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

cat > /home/vps/public_html/$user-VMESSTLS.yaml <<EOF
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
  - name: XRAY_VMESS_TLS_${user}
    server: ${domain}
    port: 443
    type: vmess
    uuid: ${uuid}
    alterId: 0
    cipher: auto
    tls: true
    skip-cert-verify: true
    servername: ${domain}
    network: ws
    ws-opts:
      path: /vmess-ws
      headers:
        Host: ${domain}
    udp: true
proxy-groups:
  - name: RyukillerZ-Autoscript
    type: select
    proxies:
      - XRAY_VMESS_TLS_${user}
      - DIRECT
rules:
  - MATCH,RyukillerZ-Autoscript
EOF

cat > /home/vps/public_html/$user-VMESSNTLS.yaml <<EOF
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
  - name: XRAY_VMESS_NON_TLS_${user}
    server: ${domain}
    port: 80
    type: vmess
    uuid: ${uuid}
    alterId: 0
    cipher: auto
    tls: false
    skip-cert-verify: true
    servername: ${domain}
    network: ws
    ws-opts:
      path: /vmess-ws
      headers:
        Host: ${domain}
    udp: true
proxy-groups:
  - name: RyukillerZ-Autoscript
    type: select
    proxies:
      - XRAY_VMESS_NON_TLS_${user}
      - DIRECT
rules:
  - MATCH,RyukillerZ-Autoscript
EOF

systemctl restart xray.service
service cron restart

clear
echo -e "" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "════════════[XRAY VMESS WS]════════════" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Remarks           : ${user}" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Domain            : ${domain}" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Port TLS          : 443" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Port None TLS     : 80" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "ID                : ${uuid}" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "AlterId           : 0" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Security          : Auto" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Network           : WS" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Path TLS          : /vmess-ws" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Path NTLS         : /vmess-ws" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "═══════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Link WS TLS       : ${vmesslink1}" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "═══════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Link WS None TLS  : ${vmesslink2}" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "═══════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "YAML WS TLS       : http://${MYIP2}:81/$user-VMESSTLS.yaml" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "═══════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "YAML WS None TLS  : http://${MYIP2}:81/$user-VMESSNTLS.yaml" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "═══════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Created On        : $hariini" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Expired On        : $exp" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "═══════════════════════════════════════" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "Autoscript By RyukillerZ" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt
echo -e "" | tee -a /usr/local/etc/xray/configlogs/vmessws-$user.txt