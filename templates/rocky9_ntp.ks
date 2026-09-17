# %post-секция для Foreman-шаблона "Rocky 9 NTP kickstart"
# Добавляется в конец стандартного "Kickstart default"
#
# Параметр ntp-server задан в Host Group Linux-Base-NTP
# При установке вместо host_param подставляется pool.ntp.org
#
# Настраивает NTP (chrony) после установки ОС

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