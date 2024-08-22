#!/bin/sh

path=/var/lib/grafana/dashboards

tab=( "wordpress"
		"mariadb"
 		"static"
		"redis"
		"ftp"
		"adminer"
		"monitorix"
		"prometheus"
		"nginx-exporter"
		"grafana"
		"cadvisor")

for i in ${tab[@]}; do
	sed "s/name=\\\\\"nginx\\\\\"/name=\\\\\"$i\\\\\"/g" $path/nginx-stats-dash.json > $path/${i}-stats-dash.json
	sed -i "s/nginx container stats/$i container stats/g" $path/${i}-stats-dash.json
done
