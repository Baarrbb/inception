#!/bin/sh


GRAF_ADMIN=$(cat /run/secrets/my_graf_admin)
GRAF_PASSWD=$(cat /run/secrets/my_graf_passwd)

sed -i "s/;admin_user = admin/admin_user = ${GRAF_ADMIN}/" /etc/grafana/grafana.ini
sed -i "s/;admin_password = admin/admin_password = ${GRAF_PASSWD}/" /etc/grafana/grafana.ini


# exec grafana-server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini

exec /usr/share/grafana/bin/grafana server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini
