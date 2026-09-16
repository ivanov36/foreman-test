# Настройка NTP после установки ОС
# Параметр ntp-server задан в Host Group "Linux-Base-NTP"

%post --log=/root/ntp-post.log
# NTP configuration via Foreman Host Group parameter
NTP_SERVER="<%= host_param('ntp-server') %>"
echo "Configuring NTP with server: ${NTP_SERVER}"

cat > /etc/chrony.conf <<EOF
server ${NTP_SERVER} iburst
driftfile /var/lib/chrony/drift
makestep 1.0 3
rtcsync
logdir /var/log/chrony
EOF

systemctl enable chronyd.service
systemctl restart chronyd.service
%end