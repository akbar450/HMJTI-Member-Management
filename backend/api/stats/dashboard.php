<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../config/database.php';

$database = new Database();
$db = $database->getConnection();

$stats = [];

// Total members
$query_total = "SELECT COUNT(*) as total FROM members";
$stmt_total = $db->prepare($query_total);
$stmt_total->execute();
$stats['total_members'] = $stmt_total->fetch(PDO::FETCH_ASSOC)['total'];

// Active count
$query_active = "SELECT COUNT(*) as total FROM members WHERE status = 'Aktif'";
$stmt_active = $db->prepare($query_active);
$stmt_active->execute();
$stats['active_count'] = $stmt_active->fetch(PDO::FETCH_ASSOC)['total'];

// Inactive count
$query_inactive = "SELECT COUNT(*) as total FROM members WHERE status = 'Tidak Aktif'";
$stmt_inactive = $db->prepare($query_inactive);
$stmt_inactive->execute();
$stats['inactive_count'] = $stmt_inactive->fetch(PDO::FETCH_ASSOC)['total'];

// Per divisi
$query_divisi = "SELECT divisi, COUNT(*) as total FROM members WHERE divisi IS NOT NULL AND divisi != '' GROUP BY divisi";
$stmt_divisi = $db->prepare($query_divisi);
$stmt_divisi->execute();
$stats['per_divisi'] = $stmt_divisi->fetchAll(PDO::FETCH_ASSOC);

// Per jabatan
$query_jabatan = "SELECT jabatan, COUNT(*) as total FROM members GROUP BY jabatan";
$stmt_jabatan = $db->prepare($query_jabatan);
$stmt_jabatan->execute();
$stats['per_jabatan'] = $stmt_jabatan->fetchAll(PDO::FETCH_ASSOC);

// Per angkatan
$query_angkatan = "SELECT angkatan, COUNT(*) as total FROM members GROUP BY angkatan ORDER BY angkatan DESC";
$stmt_angkatan = $db->prepare($query_angkatan);
$stmt_angkatan->execute();
$stats['per_angkatan'] = $stmt_angkatan->fetchAll(PDO::FETCH_ASSOC);

http_response_code(200);
echo json_encode($stats);
?>
