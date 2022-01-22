#!/bin/bash

if [[ ! "$ENABLE_RELAY" =~ ^[T-t]rue* ]]; then
   unset ENABLE_RELAY;
fi

if [[ "$GENERATE_TEMPLATE" =~ ^[T-t]rue* ]]; then
    cat /etc/template.xml | mo > /etc/icecast.xml
fi

exec "$@"