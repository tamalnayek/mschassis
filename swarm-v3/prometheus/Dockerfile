FROM prom/prometheus 
USER root
COPY ./config/prometheus.yml /etc/prometheus/prometheus.yml
RUN chmod 777 /etc/prometheus/prometheus.yml
RUN ls -ltra /etc/prometheus