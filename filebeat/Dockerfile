FROM filebeat:7.17.14
COPY --chown=root:filebeat filebeat.docker.elastic.yml /usr/share/filebeat/filebeat.yml
CMD ["filebeat","-E","output.elasticsearch.hosts=[10.10.10.10:9200]"]


