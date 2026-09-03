<?php

header('Content-Type: application/json');

echo json_encode([
    'status' => 'success',
    'message' => 'API application is serving requests',
    'server_time' => date('c')
]);
