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

if(
    !empty($data->nim) &&
    !empty($data->nama_lengkap) &&
    !empty($data->jenis_kelamin) &&
    !empty($data->program_studi) &&
    !empty($data->angkatan) &&
    !empty($data->jabatan) &&
    !empty($data->tanggal_bergabung)
){
    $check_query = "SELECT id FROM members WHERE nim = :nim LIMIT 0,1";
    $stmt_check = $db->prepare($check_query);
    $stmt_check->bindParam(':nim', $data->nim);
    $stmt_check->execute();
    
    if($stmt_check->rowCount() > 0){
        http_response_code(400);
        echo json_encode(array("message" => "NIM sudah terdaftar."));
        exit;
    }

    $query = "INSERT INTO members SET
                nim=:nim, nama_lengkap=:nama_lengkap, jenis_kelamin=:jenis_kelamin,
                program_studi=:program_studi, angkatan=:angkatan, no_hp=:no_hp,
                email=:email, alamat=:alamat, jabatan=:jabatan, divisi=:divisi,
                status=:status, tanggal_bergabung=:tanggal_bergabung";
                
    $stmt = $db->prepare($query);

    $stmt->bindParam(":nim", $data->nim);
    $stmt->bindParam(":nama_lengkap", $data->nama_lengkap);
    $stmt->bindParam(":jenis_kelamin", $data->jenis_kelamin);
    $stmt->bindParam(":program_studi", $data->program_studi);
    $stmt->bindParam(":angkatan", $data->angkatan);
    
    $no_hp = isset($data->no_hp) ? $data->no_hp : null;
    $stmt->bindParam(":no_hp", $no_hp);
    
    $email = isset($data->email) ? $data->email : null;
    $stmt->bindParam(":email", $email);
    
    $alamat = isset($data->alamat) ? $data->alamat : null;
    $stmt->bindParam(":alamat", $alamat);
    
    $stmt->bindParam(":jabatan", $data->jabatan);
    
    $divisi = isset($data->divisi) ? $data->divisi : null;
    $stmt->bindParam(":divisi", $divisi);
    
    $status = isset($data->status) ? $data->status : 'Aktif';
    $stmt->bindParam(":status", $status);
    
    $stmt->bindParam(":tanggal_bergabung", $data->tanggal_bergabung);

    if($stmt->execute()){
        http_response_code(201);
        echo json_encode(array("message" => "Member berhasil ditambahkan."));
    } else{
        http_response_code(503);
        echo json_encode(array("message" => "Gagal menambahkan member."));
    }
} else{
    http_response_code(400);
    echo json_encode(array("message" => "Data tidak lengkap."));
}
?>
