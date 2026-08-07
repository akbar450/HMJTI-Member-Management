<?php
class Database {
    private $host = 'localhost';
    private $db_name = 'hmjti_member_management';
    private $username = 'root';
    private $password = 'akbar2613';
    public $conn;

    public function getConnection() {
        $this->conn = null;
        try {
            $this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name . ";charset=utf8mb4", $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $exception) {
            header('Content-Type: application/json');
            http_response_code(500);
            echo json_encode([
                "success" => false,
                "message" => "Gagal terhubung ke server database."
            ]);
            exit;
        }
        return $this->conn;
    }
}
?>
