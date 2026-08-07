<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../models/Anggota.php';
require_once __DIR__ . '/../helpers/Response.php';

class DashboardController {
    public function getStats() {
        $database = new Database();
        $db = $database->getConnection();

        $anggotaModel = new Anggota($db);
        $stats = $anggotaModel->getDashboardStats();

        Response::success("Data statistik berhasil dimuat", $stats);
    }
}
?>
