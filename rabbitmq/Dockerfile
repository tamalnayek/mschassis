FROM rabbitmq:3-management 
USER root
COPY ./config/definitions.json /etc/rabbitmq/definitions.json
RUN chmod 777 /etc/rabbitmq/definitions.json