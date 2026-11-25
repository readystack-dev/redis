#!/bin/sh
# ReadyStack redis entrypoint. The shipped config keeps upstream's protected mode: with no password, only clients
# inside this container may connect. REDIS_PASSWORD sets `requirepass` through a mode-600 include file (not the command
# line, where it would show in the process list) so authenticated clients from other hosts can connect.
set -e
if [ -n "${REDIS_PASSWORD:-}" ]; then
  AUTH=/tmp/readystack-auth.conf
  ( umask 077; printf 'requirepass "%s"\n' "$(printf '%s' "${REDIS_PASSWORD}" | sed 's/[\\"]/\\&/g')" > "$AUTH" )
  exec redis-server /etc/redis/redis.conf --include "$AUTH" "$@"
fi
exec redis-server /etc/redis/redis.conf "$@"
