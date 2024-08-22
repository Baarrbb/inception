#!/bin/sh

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
	sed "s/name=\\\\\"nginx\\\\\"/name=\\\\\"$i\\\\\"/g" nginx-stats-dash.json > ${i}-stats-dash.json
	sed -i "s/nginx container stats/$i container stats/g" ${i}-stats-dash.json
done
