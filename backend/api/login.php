<?php
require_once __DIR__ . '/../config/cors.php';
require_once __DIR__ . '/../controllers/AuthController.php';

(new AuthController())->login();
?>
