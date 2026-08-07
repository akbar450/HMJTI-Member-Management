<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/database.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

if(!empty($data->id)) {
    $id = $data->id;
    
    // Check if NIM is being updated and if it's unique
    if(!empty($data->nim)) {
        $check_query = "SELECT id FROM members WHERE nim = :nim AND id != :id LIMIT 0,1";
        $stmt_check = $db->prepare($check_query);
        $stmt_check->bindParam(':nim', $data->nim);
        $stmt_check->bindParam(':id', $id);
        $stmt_check->execute();
        
        if($stmt_check->rowCount() > 0){
            http_response_code(400);
            echo json_encode(array("message" => "NIM sudah terdaftar."));
            exit;
        }
    }

    $updates = [];
    $params = [':id' => $id];

    $allowed_fields = ['nim', 'nama_lengkap', 'jenis_kelamin', 'program_studi', 'angkatan', 'no_hp', 'email', 'alamat', 'jabatan', 'divisi', 'status', 'tanggal_bergabung'];

    foreach($allowed_fields as $field) {
        if(isset($data->$field)) {
            $updates[] = "{$field} = :{$field}";
            $params[":{$field}"] = $data->$field;
        }
    }

    if (count($updates) > 0) {
        $query = "UPDATE members SET " . implode(", ", $updates) . " WHERE id = :id";
        $stmt = $db->prepare($query);

        foreach($params as $key => &$val) {
            $stmt->bindParam($key, $val);
        }

        if($stmt->execute()){
            http_response_code(200);
            echo json_encode(array("message" => "Member berhasil diupdate."));
        } else {
            http_response_code(503);
            echo json_encode(array("message" => "Gagal mengupdate member."));
        }
    } else {
        http_response_code(400);
        echo json_encode(array("message" => "Tidak ada data yang diupdate."));
    }

} else {
    http_response_code(400);
    echo json_encode(array("message" => "ID tidak diberikan."));
}
?>
