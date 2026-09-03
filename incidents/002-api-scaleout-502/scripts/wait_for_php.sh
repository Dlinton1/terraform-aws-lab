#!/bin/bash

set -e

PHP_CONTAINER="scaleout-php"
MAX_ATTEMPTS=15
SLEEP_SECONDS=2

echo "Waiting for PHP-FPM..."

for attempt in $(seq 1 "$MAX_ATTEMPTS"); do

    if docker exec "$PHP_CONTAINER" php-fpm -t >/dev/null 2>&1; then

        echo "PHP-FPM configuration is valid."

        if curl -s -f http://localhost:8081/api/health.php >/dev/null 2>&1; then
            echo "PHP application is serving requests."
            exit 0
        fi
    fi

    echo "Attempt $attempt/$MAX_ATTEMPTS - PHP not ready."
    sleep "$SLEEP_SECONDS"

done

echo "PHP-FPM failed readiness check."
exit 1
