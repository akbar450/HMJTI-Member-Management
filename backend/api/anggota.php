<?php
require_once __DIR__ . '/../config/cors.php';
require_once __DIR__ . '/../controllers/AnggotaController.php';

$method = $_SERVER['REQUEST_METHOD'];
$controller = new AnggotaController();
$id = $_GET['id'] ?? null;

if ($method === 'GET') {
    if ($id) {
        $controller->show($id);
    } else {
        $controller->index();
    }
} elseif ($method === 'POST') {
    $isUpload = strpos($_SERVER['REQUEST_URI'], 'upload') !== false;
    if ($isUpload) {
        $controller->uploadPhoto($id);
    } else {
        $controller->store();
    }
} elseif ($method === 'PUT') {
    $controller->update($id);
} elseif ($method === 'DELETE') {
    $controller->destroy($id);
}
?>
