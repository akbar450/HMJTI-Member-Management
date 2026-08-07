<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../config/database.php';

$database = new Database();
$db = $database->getConnection();

$where = [];
$params = [];

if (isset($_GET['jabatan'])) {
    $where[] = "jabatan = :jabatan";
    $params[':jabatan'] = $_GET['jabatan'];
}
if (isset($_GET['divisi'])) {
    $where[] = "divisi = :divisi";
    $params[':divisi'] = $_GET['divisi'];
}
if (isset($_GET['angkatan'])) {
    $where[] = "angkatan = :angkatan";
    $params[':angkatan'] = $_GET['angkatan'];
}
if (isset($_GET['status'])) {
    $where[] = "status = :status";
    $params[':status'] = $_GET['status'];
}

$where_clause = "";
if (count($where) > 0) {
    $where_clause = " WHERE " . implode(" AND ", $where);
}

$order_by = "ORDER BY created_at DESC";
if (isset($_GET['sort'])) {
    switch ($_GET['sort']) {
        case 'nama_asc': $order_by = "ORDER BY nama_lengkap ASC"; break;
        case 'nama_desc': $order_by = "ORDER BY nama_lengkap DESC"; break;
        case 'nim_asc': $order_by = "ORDER BY nim ASC"; break;
        case 'nim_desc': $order_by = "ORDER BY nim DESC"; break;
        case 'tanggal_desc': $order_by = "ORDER BY tanggal_bergabung DESC"; break;
    }
}

$query = "SELECT * FROM members" . $where_clause . " " . $order_by;
$stmt = $db->prepare($query);

foreach ($params as $key => &$val) {
    $stmt->bindParam($key, $val);
}

$stmt->execute();
$num = $stmt->rowCount();

if($num > 0){
    $members_arr = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        $members_arr[] = $row;
    }
    http_response_code(200);
    echo json_encode($members_arr);
} else {
    http_response_code(200);
    echo json_encode(array());
}
?>
