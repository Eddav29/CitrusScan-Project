<?php

return [
    'paths' => ['api/*', 'sanctum/csrf-cookie', 'login', 'register', 'logout'],

    'allowed_methods' => ['*'],

    'allowed_origins' => ['*'],  // Dalam production, ganti dengan domain spesifik

    'allowed_origins_patterns' => [],

    'allowed_headers' => [
        'X-Requested-With',
        'Content-Type',
        'X-Token-Auth',
        'Authorization',
        'X-XSRF-TOKEN',
        'X-CSRF-TOKEN',
        'Origin',
        'Accept'
    ],

    'exposed_headers' => [],

    'max_age' => 0,

    // Aktifkan ini karena menggunakan Sanctum
    'supports_credentials' => true,
];