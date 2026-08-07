<?php
require_once __DIR__ . '/config/cors.php';
require_once __DIR__ . '/controllers/AuthController.php';
require_once __DIR__ . '/controllers/DashboardController.php';
require_once __DIR__ . '/controllers/AnggotaController.php';
require_once __DIR__ . '/helpers/Response.php';
require_once __DIR__ . '/routes/api.php';

$requestUri = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];

// Parse request path
$path = parse_url($requestUri, PHP_URL_PATH);

// Remove base path prefix if any (e.g. /hmjti_api or /backend)
$path = preg_replace('#^/hmjti_api#', '', $path);
$path = preg_replace('#^/backend#', '', $path);
$path = rtrim($path, '/');

// Delegate route handling to ApiRouter
if (!ApiRouter::handleRequest($path, $method)) {
    Response::error("Endpoint tidak ditemukan", 404);
}
?>
