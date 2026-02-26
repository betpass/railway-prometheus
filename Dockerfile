FROM prom/prometheus

# copy the Prometheus configuration file
COPY prometheus.yml /etc/prometheus/prometheus.yml

# expose the Prometheus server port
EXPOSE 9090

# set the entrypoint command
USER root
ENTRYPOINT ["/bin/sh", "-ec"]
CMD ["test -n \"${AFFILIAPASS_API_KEY:-}\" || { echo \"AFFILIAPASS_API_KEY is required\" >&2; exit 1; }; mkdir -p /etc/prometheus/secrets; printf '%s' \"$AFFILIAPASS_API_KEY\" > /etc/prometheus/secrets/affiliapass_api_key; chmod 600 /etc/prometheus/secrets/affiliapass_api_key; exec /bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --storage.tsdb.retention.time=365d --web.console.libraries=/usr/share/prometheus/console_libraries --web.console.templates=/usr/share/prometheus/consoles --web.external-url=http://localhost:9090 --log.level=info"]
 
