#!/bin/bash
#Autoscript-Lite By RyukillerZ

#----- Auto Remove Vmess
data=( `cat /usr/local/etc/xray/config.json | grep '^#~&' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#~& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#~& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
rm -f /usr/local/etc/xray/$user-tls.json /usr/local/etc/xray/$user-none.json
rm -f /home/vps/public_html/$user-VMESSTLS.yaml /home/vps/public_html/$user-VMESSNTLS.yaml
rm -f /usr/local/etc/xray/configlogs/vmessws-$user.txt
systemctl restart xray.service
systemctl restart xray@none.service
fi
done

#----- Auto Remove Vless
data=( `cat /usr/local/etc/xray/config.json | grep '^#@' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#@ $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#@ $user $exp/,/^},{/d" /usr/local/etc/xray/config.json

harini=$(grep -E "^vless " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 4)
uuid=$(grep -E "^vless " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 5)
cust_id=$(grep -E "^vless " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 6)
seller_id=$(grep -E "^vless " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 7)
sed -i "/vless $user $exp/d" "/root/.premium/.database"
echo "vless $user $exp $harini $uuid $cust_id $seller_id inactive" >>"/root/.premium/.database"

rm -f /home/vps/public_html/$user-VLESSTLS.yaml /home/vps/public_html/$user-VLESSNTLS.yaml
rm -f /usr/local/etc/xray/configlogs/vlessws-$user.txt
systemctl restart xray.service
systemctl restart xray@none.service
fi
done

#----- Auto Remove Trojan
data=( `cat /usr/local/etc/xray/config.json | grep '^#&' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json

harini=$(grep -E "^trojanws " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 4)
uuid=$(grep -E "^trojanws " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 5)
cust_id=$(grep -E "^trojanws " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 6)
seller_id=$(grep -E "^trojanws " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 7)
sed -i "/trojanws $user $exp/d" "/root/.premium/.database"
echo "trojanws $user $exp $harini $uuid $cust_id $seller_id inactive" >>"/root/.premium/.database"

rm -f /home/vps/public_html/$user-TROJANTLS.yaml
rm -f /usr/local/etc/xray/configlogs/trojanws-$user.txt
systemctl restart xray.service
systemctl restart xray@none.service
fi
done

#----- Auto Remove Trojan TCP
data=( `cat /usr/local/etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
rm -f /home/vps/public_html/$user-TRTCP.yaml
rm -f /usr/local/etc/xray/configlogs/trojantcp-$user.txt
systemctl restart xray.service
fi
done

#----- Auto Remove Vless TCP XTLS
data=( `cat /usr/local/etc/xray/config.json | grep '^#!' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#! $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#! $user $exp/,/^},{/d" /usr/local/etc/xray/config.json

harini=$(grep -E "^xtls " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 4)
uuid=$(grep -E "^xtls " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 5)
cust_id=$(grep -E "^xtls " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 6)
seller_id=$(grep -E "^xtls " "/root/.premium/.database" | grep -w "$user $exp" | cut -d ' ' -f 7)
sed -i "/xtls $user $exp/d" "/root/.premium/.database"
echo "xtls $user $exp $harini $uuid $cust_id $seller_id inactive" >>"/root/.premium/.database"

rm -f /home/vps/public_html/$user-VLESSDIRECT.yaml /home/vps/public_html/$user-VLESSSPLICE.yaml
rm -f /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
systemctl restart xray.service
fi
done
