<?php

header('Content-Type: application/json');

http_response_code(200);

echo json_encode([
    'status' => 'healthy',
    'php' => 'ready',
    'message' => 'PHP-FPM successfully executed this health check'
]);
