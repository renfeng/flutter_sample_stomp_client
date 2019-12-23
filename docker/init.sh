#!/bin/bash
export PATH="/opt/rabbitmq/sbin:/usr/local/bin:$PATH"

rabbitmqctl add_user flutter flutter
rabbitmqctl set_user_tags flutter administrator
rabbitmqctl set_permissions flutter --vhost / '.*' '.*' '.*'
