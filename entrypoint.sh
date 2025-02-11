#!/bin/sh
if [ -z "$PORT" ]; then
  export PORT=80
fi

envsubst '$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'