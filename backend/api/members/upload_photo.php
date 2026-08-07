<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/database.php';

$database = new Database();
$db = $database->getConnection();

if(isset($_POST['id']) && isset($_FILES['photo'])){
    $id = $_POST['id'];
    $target_dir = "../../uploads/photos/";
    
    if (!file_exists($target_dir)) {
        mkdir($target_dir, 0777, true);
    }

    $query_old = "SELECT foto FROM members WHERE id = ?";
    $stmt_old = $db->prepare($query_old);
    $stmt_old->bindParam(1, $id);
    $stmt_old->execute();
    if($stmt_old->rowCount() > 0) {
        $row = $stmt_old->fetch(PDO::FETCH_ASSOC);
        $old_foto = $row['foto'];
        if($old_foto && file_exists($target_dir . $old_foto)) {
            unlink($target_dir . $old_foto);
        }
    }

    $file_extension = strtolower(pathinfo($_FILES["photo"]["name"], PATHINFO_EXTENSION));
    $new_filename = uniqid() . '_' . $id . '.' . $file_extension;
    $target_file = $target_dir . $new_filename;

    $valid_extensions = array("jpg", "jpeg", "png", "gif");

    if(in_array($file_extension, $valid_extensions)) {
        if(move_uploaded_file($_FILES["photo"]["tmp_name"], $target_file)){
            $query = "UPDATE members SET foto = :foto WHERE id = :id";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':foto', $new_filename);
            $stmt->bindParam(':id', $id);

            if($stmt->execute()){
                http_response_code(200);
                echo json_encode(array("message" => "Foto berhasil diupload.", "filename" => $new_filename));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Gagal update database."));
            }
        } else {
            http_response_code(500);
            echo json_encode(array("message" => "Terjadi kesalahan saat upload file."));
        }
    } else {
        http_response_code(400);
        echo json_encode(array("message" => "Format file tidak valid. Hanya JPG, JPEG, PNG & GIF."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "ID atau file foto tidak diberikan."));
}
?>
