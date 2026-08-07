<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../models/Anggota.php';
require_once __DIR__ . '/../helpers/Response.php';

class AnggotaController {
    private $db;
    private $anggotaModel;

    public function __construct() {
        $database = new Database();
        $this->db = $database->getConnection();
        $this->anggotaModel = new Anggota($this->db);
    }

    public function index() {
        $search = $_GET['q'] ?? $_GET['search'] ?? null;
        $angkatan = $_GET['angkatan'] ?? null;
        $jabatan = $_GET['jabatan'] ?? null;
        $status = $_GET['status'] ?? null;
        $sort = $_GET['sort'] ?? null;

        $list = $this->anggotaModel->getAll($search, $angkatan, $jabatan, $status, $sort);
        Response::success("Data anggota berhasil dimuat", $list);
    }

    public function show($id) {
        if (!$id) {
            Response::error("ID Anggota tidak valid", 400);
        }

        $anggota = $this->anggotaModel->getById($id);
        if (!$anggota) {
            Response::error("Data tidak ditemukan", 404);
        }

        Response::success("Detail anggota berhasil dimuat", $anggota);
    }

    public function store() {
        $data = json_decode(file_get_contents("php://input"), true);

        // Validation rules according to PRD section 10
        if (empty($data['nama']) || strlen($data['nama']) < 3 || strlen($data['nama']) > 100) {
            Response::error("Nama wajib diisi (3-100 karakter)", 400);
        }

        if (empty($data['nim']) || strlen($data['nim']) > 30) {
            Response::error("NIM wajib diisi (maksimal 30 karakter)", 400);
        }

        if ($this->anggotaModel->checkNimExists($data['nim'])) {
            Response::error("NIM sudah terdaftar", 400);
        }

        if (empty($data['email']) || !filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            Response::error("Email wajib diisi dengan format valid", 400);
        }

        if ($this->anggotaModel->checkEmailExists($data['email'])) {
            Response::error("Email sudah terdaftar", 400);
        }

        if (empty($data['nomor_hp']) || strlen($data['nomor_hp']) < 10 || strlen($data['nomor_hp']) > 15) {
            Response::error("Nomor HP wajib diisi (10-15 digit)", 400);
        }

        $validJabatan = [
            'Ketua',
            'Wakil Ketua',
            'Sekretaris',
            'Bendahara',
            'Koor Divisi Humas',
            'Anggota Divisi Humas',
            'Koor Divisi Minat & Bakat',
            'Anggota Divisi Minat & Bakat',
            'Anggota Biasa'
        ];
        if (empty($data['jabatan']) || !in_array($data['jabatan'], $validJabatan)) {
            Response::error("Jabatan tidak valid", 400);
        }

        $validStatus = ['Aktif', 'Non Aktif'];
        if (empty($data['status']) || !in_array($data['status'], $validStatus)) {
            Response::error("Status tidak valid", 400);
        }

        if (empty($data['angkatan'])) {
            Response::error("Angkatan wajib diisi", 400);
        }

        $id = $this->anggotaModel->create($data);
        if ($id) {
            Response::success("Data berhasil ditambahkan", ["id" => $id], 201);
        } else {
            Response::error("Gagal menambahkan data anggota", 500);
        }
    }

    public function update($id) {
        $data = json_decode(file_get_contents("php://input"), true);
        if (!$id && isset($data['id'])) {
            $id = $data['id'];
        }

        if (!$id) {
            Response::error("ID Anggota tidak valid", 400);
        }

        $existing = $this->anggotaModel->getById($id);
        if (!$existing) {
            Response::error("Data anggota tidak ditemukan", 404);
        }

        if (empty($data['nama']) || strlen($data['nama']) < 3 || strlen($data['nama']) > 100) {
            Response::error("Nama wajib diisi (3-100 karakter)", 400);
        }

        if (empty($data['nim']) || strlen($data['nim']) > 30) {
            Response::error("NIM wajib diisi (maksimal 30 karakter)", 400);
        }

        if ($this->anggotaModel->checkNimExists($data['nim'], $id)) {
            Response::error("NIM sudah digunakan oleh anggota lain", 400);
        }

        if (empty($data['email']) || !filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            Response::error("Email wajib diisi dengan format valid", 400);
        }

        if ($this->anggotaModel->checkEmailExists($data['email'], $id)) {
            Response::error("Email sudah digunakan oleh anggota lain", 400);
        }

        if (empty($data['nomor_hp']) || strlen($data['nomor_hp']) < 10 || strlen($data['nomor_hp']) > 15) {
            Response::error("Nomor HP wajib diisi (10-15 digit)", 400);
        }

        $result = $this->anggotaModel->update($id, $data);
        if ($result) {
            Response::success("Data berhasil diubah");
        } else {
            Response::error("Gagal mengubah data anggota", 500);
        }
    }

    public function destroy($id) {
        if (!$id) {
            $data = json_decode(file_get_contents("php://input"), true);
            $id = $data['id'] ?? null;
        }

        if (!$id) {
            Response::error("ID Anggota tidak valid", 400);
        }

        $existing = $this->anggotaModel->getById($id);
        if (!$existing) {
            Response::error("Data anggota tidak ditemukan", 404);
        }

        $result = $this->anggotaModel->delete($id);
        if ($result) {
            Response::success("Data berhasil dihapus");
        } else {
            Response::error("Gagal menghapus data anggota", 500);
        }
    }

    public function uploadPhoto($id) {
        if (!$id && isset($_POST['id'])) {
            $id = $_POST['id'];
        }

        if (!$id) {
            Response::error("ID Anggota tidak valid", 400);
        }

        if (!isset($_FILES['foto']) || $_FILES['foto']['error'] !== UPLOAD_ERR_OK) {
            Response::error("File foto wajib diunggah", 400);
        }

        $uploadDir = __DIR__ . '/../uploads/';
        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        $fileExtension = pathinfo($_FILES['foto']['name'], PATHINFO_EXTENSION);
        $fileName = 'foto_' . $id . '_' . time() . '.' . strtolower($fileExtension);
        $targetPath = $uploadDir . $fileName;

        if (move_uploaded_file($_FILES['foto']['tmp_name'], $targetPath)) {
            $photoUrl = 'uploads/' . $fileName;
            $this->anggotaModel->updateFoto($id, $photoUrl);
            Response::success("Foto berhasil diunggah", ["file_name" => $photoUrl]);
        } else {
            Response::error("Gagal mengunggah foto", 500);
        }
    }
}
?>
