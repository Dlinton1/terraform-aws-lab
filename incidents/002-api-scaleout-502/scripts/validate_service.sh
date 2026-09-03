#!/bin/bash

set -e

URL="http://localhost:8081/api/health.php"
MAX_ATTEMPTS=15
SLEEP_SECONDS=2

echo "Validating application readiness..."

for attempt in $(seq 1 "$MAX_ATTEMPTS"); do

    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || true)

    echo "Attempt $attempt/$MAX_ATTEMPTS - HTTP $HTTP_CODE"

    if [ "$HTTP_CODE" = "200" ]; then
        echo "Application is ready."
        exit 0
    fi

    echo "Application not ready. Waiting..."
    sleep "$SLEEP_SECONDS"

done

echo "ERROR: Application failed readiness validation."
exit 1
