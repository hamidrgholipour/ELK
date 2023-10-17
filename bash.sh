#after runnig elk container we can take a cert and tocken from elastic search

#reset pass
docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -i
docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
#copy cert
docker cp es01:/usr/share/elasticsearch/config/certs/http_ca.crt .
#check elasti
curl --cacert http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200
#get verification cod or use a url that show after installing kibana
docker exec -it kibana /bin/kibana-verification
#pipe line must be in the logstash dir 
logstash -f /usr/share/logstash/pipeline/logstash.conf

chmod 660 /etc/logstash/certs/http_ca.crt
chown root:logstash /etc/logstash/certs/http_ca.crt

#test logstash 
logstash -e 'input { stdin { } } output { stdout {} }'

#get key 
openssl x509 -fingerprint -sha256 -in cert.crt
#lowercase and no : 
