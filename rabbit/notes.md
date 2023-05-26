# RabbitMQ

## Versions
Default `rabbitmq` has no management plugin added, use `` rabbitmq:3-management.

> If you wish to change the default username and password of guest / guest, you can do so with the RABBITMQ_DEFAULT_USER and RABBITMQ_DEFAULT_PASS environmental variables. These variables were available previously in the docker-specific entrypoint shell script but are now available in RabbitMQ directly.

Source: 
 - https://hub.docker.com/_/rabbitmq

## Defaults
 - username = guest
 - password = guest
 - port = 5672
 - ui-port = 15672
