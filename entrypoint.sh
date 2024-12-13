#!/bin/sh
set -e
cd /app

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if [ -n "$GITHUB_KEY" ]; then
  bundle config GITHUB__COM $GITHUB_KEY
fi

if ! bundle check ; then
  bundle install
fi

if ping -c1 -t 1 $POSTGRES_HOST 2>/dev/null 1>/dev/null; then
  bundle exec rails db:create || true
  bundle exec rails db:migrate || echo "No pending migrations found."
fi

exec "$@"