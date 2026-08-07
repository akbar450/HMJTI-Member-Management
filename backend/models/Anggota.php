<?php
class Anggota {
    private $conn;
    private $table_name = "anggota";

    public function __construct($db) {
        $this->conn = $db;
    }

    public function getAll($search = null, $angkatan = null, $jabatan = null, $status = null, $sort = null) {
        $query = "SELECT id, nama, nim, angkatan, email, nomor_hp, jabatan, status, foto, created_at, updated_at FROM " . $this->table_name . " WHERE 1=1";
        $params = [];

        if (!empty($search)) {
            $query .= " AND (nama LIKE :search OR nim LIKE :search)";
            $params[':search'] = '%' . $search . '%';
        }

        if (!empty($angkatan)) {
            $query .= " AND angkatan = :angkatan";
            $params[':angkatan'] = $angkatan;
        }

        if (!empty($jabatan)) {
            $query .= " AND jabatan = :jabatan";
            $params[':jabatan'] = $jabatan;
        }

        if (!empty($status)) {
            $query .= " AND status = :status";
            $params[':status'] = $status;
        }

        switch ($sort) {
            case 'Nama Z-A':
            case 'nama_desc':
                $query .= " ORDER BY nama DESC";
                break;
            case 'Angkatan Terbaru':
            case 'angkatan_desc':
                $query .= " ORDER BY angkatan DESC, nama ASC";
                break;
            case 'Angkatan Terlama':
            case 'angkatan_asc':
                $query .= " ORDER BY angkatan ASC, nama ASC";
                break;
            case 'Nama A-Z':
            case 'nama_asc':
            default:
                $query .= " ORDER BY nama ASC";
                break;
        }

        $stmt = $this->conn->prepare($query);
        foreach ($params as $key => $value) {
            $stmt->bindValue($key, $value);
        }
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById($id) {
        $query = "SELECT id, nama, nim, angkatan, email, nomor_hp, jabatan, status, foto, created_at, updated_at FROM " . $this->table_name . " WHERE id = :id LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            return $stmt->fetch(PDO::FETCH_ASSOC);
        }
        return null;
    }

    public function checkNimExists($nim, $excludeId = null) {
        $query = "SELECT id FROM " . $this->table_name . " WHERE nim = :nim";
        if ($excludeId) {
            $query .= " AND id != :excludeId";
        }
        $query .= " LIMIT 1";

        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":nim", $nim);
        if ($excludeId) {
            $stmt->bindParam(":excludeId", $excludeId);
        }
        $stmt->execute();

        return $stmt->rowCount() > 0;
    }

    public function checkEmailExists($email, $excludeId = null) {
        $query = "SELECT id FROM " . $this->table_name . " WHERE email = :email";
        if ($excludeId) {
            $query .= " AND id != :excludeId";
        }
        $query .= " LIMIT 1";

        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $email);
        if ($excludeId) {
            $stmt->bindParam(":excludeId", $excludeId);
        }
        $stmt->execute();

        return $stmt->rowCount() > 0;
    }

    public function create($data) {
        $query = "INSERT INTO " . $this->table_name . " 
                  (nama, nim, angkatan, email, nomor_hp, jabatan, status, foto) 
                  VALUES (:nama, :nim, :angkatan, :email, :nomor_hp, :jabatan, :status, :foto)";

        $stmt = $this->conn->prepare($query);

        $foto = isset($data['foto']) ? $data['foto'] : null;
        $status = isset($data['status']) ? $data['status'] : 'Aktif';

        $stmt->bindParam(":nama", $data['nama']);
        $stmt->bindParam(":nim", $data['nim']);
        $stmt->bindParam(":angkatan", $data['angkatan']);
        $stmt->bindParam(":email", $data['email']);
        $stmt->bindParam(":nomor_hp", $data['nomor_hp']);
        $stmt->bindParam(":jabatan", $data['jabatan']);
        $stmt->bindParam(":status", $status);
        $stmt->bindParam(":foto", $foto);

        if ($stmt->execute()) {
            return $this->conn->lastInsertId();
        }
        return false;
    }

    public function update($id, $data) {
        $query = "UPDATE " . $this->table_name . " SET 
                  nama = :nama, 
                  nim = :nim, 
                  angkatan = :angkatan, 
                  email = :email, 
                  nomor_hp = :nomor_hp, 
                  jabatan = :jabatan, 
                  status = :status";
        
        if (array_key_exists('foto', $data)) {
            $query .= ", foto = :foto";
        }
        $query .= " WHERE id = :id";

        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":nama", $data['nama']);
        $stmt->bindParam(":nim", $data['nim']);
        $stmt->bindParam(":angkatan", $data['angkatan']);
        $stmt->bindParam(":email", $data['email']);
        $stmt->bindParam(":nomor_hp", $data['nomor_hp']);
        $stmt->bindParam(":jabatan", $data['jabatan']);
        $stmt->bindParam(":status", $data['status']);
        $stmt->bindParam(":id", $id);

        if (array_key_exists('foto', $data)) {
            $stmt->bindParam(":foto", $data['foto']);
        }

        return $stmt->execute();
    }

    public function delete($id) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        return $stmt->execute();
    }

    public function updateFoto($id, $foto) {
        $query = "UPDATE " . $this->table_name . " SET foto = :foto WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":foto", $foto);
        $stmt->bindParam(":id", $id);
        return $stmt->execute();
    }

    public function getDashboardStats() {
        // Total anggota
        $q1 = "SELECT COUNT(*) as total_anggota FROM " . $this->table_name;
        $s1 = $this->conn->query($q1)->fetch(PDO::FETCH_ASSOC);

        // Total pengurus (jabatan != 'Anggota Biasa')
        $q2 = "SELECT COUNT(*) as total_pengurus FROM " . $this->table_name . " WHERE jabatan NOT IN ('Anggota Biasa', 'Anggota')";
        $s2 = $this->conn->query($q2)->fetch(PDO::FETCH_ASSOC);

        // Total angkatan (distinct angkatan)
        $q3 = "SELECT COUNT(DISTINCT angkatan) as total_angkatan FROM " . $this->table_name;
        $s3 = $this->conn->query($q3)->fetch(PDO::FETCH_ASSOC);

        // Anggota aktif
        $q4 = "SELECT COUNT(*) as anggota_aktif FROM " . $this->table_name . " WHERE status = 'Aktif'";
        $s4 = $this->conn->query($q4)->fetch(PDO::FETCH_ASSOC);

        return [
            "total_anggota" => (int)($s1['total_anggota'] ?? 0),
            "total_pengurus" => (int)($s2['total_pengurus'] ?? 0),
            "total_angkatan" => (int)($s3['total_angkatan'] ?? 0),
            "anggota_aktif" => (int)($s4['anggota_aktif'] ?? 0)
        ];
    }
}
?>
