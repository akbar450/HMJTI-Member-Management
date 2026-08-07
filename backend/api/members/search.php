<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../config/database.php';

$database = new Database();
$db = $database->getConnection();

$q = isset($_GET['q']) ? $_GET['q'] : '';

if(!empty($q)){
    $search_term = "%{$q}%";
    $query = "SELECT * FROM members WHERE nama_lengkap LIKE ? OR nim LIKE ? ORDER BY created_at DESC";
    $stmt = $db->prepare($query);
    
    $stmt->bindParam(1, $search_term);
    $stmt->bindParam(2, $search_term);
    
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
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Kata kunci pencarian kosong."));
}
?>
