CREATE DATABASE IF NOT EXISTS hmjti_db;
USE hmjti_db;

CREATE TABLE IF NOT EXISTS members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(20) UNIQUE NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('L','P') NOT NULL,
    program_studi VARCHAR(100) NOT NULL,
    angkatan YEAR NOT NULL,
    no_hp VARCHAR(20) NULL,
    email VARCHAR(100) NULL,
    alamat TEXT NULL,
    jabatan ENUM('Ketua','Wakil Ketua','Sekretaris','Bendahara','Koordinator Divisi','Anggota Divisi','Anggota Umum') NOT NULL,
    divisi ENUM('Humas','Minat dan Bakat') NULL,
    status ENUM('Aktif','Tidak Aktif') NOT NULL DEFAULT 'Aktif',
    foto VARCHAR(255) NULL,
    tanggal_bergabung DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO members (nim, nama_lengkap, jenis_kelamin, program_studi, angkatan, no_hp, email, alamat, jabatan, divisi, status, tanggal_bergabung) VALUES
('2024.TI.001', 'Budi Santoso', 'L', 'Teknologi Informasi', 2022, '081234567890', 'budi@example.com', 'Jl. Sudirman No. 1', 'Ketua', NULL, 'Aktif', '2023-01-10'),
('2024.TI.002', 'Siti Aminah', 'P', 'Teknologi Informasi', 2022, '081234567891', 'siti@example.com', 'Jl. Merdeka No. 2', 'Wakil Ketua', NULL, 'Aktif', '2023-01-10'),
('2024.TI.003', 'Ahmad Rizal', 'L', 'Teknologi Informasi', 2022, '081234567892', 'ahmad@example.com', 'Jl. Pahlawan No. 3', 'Sekretaris', NULL, 'Aktif', '2023-01-10'),
('2024.TI.004', 'Dewi Lestari', 'P', 'Teknologi Informasi', 2022, '081234567893', 'dewi@example.com', 'Jl. Diponegoro No. 4', 'Bendahara', NULL, 'Aktif', '2023-01-10'),
('2024.TI.005', 'Rudi Heryanto', 'L', 'Teknologi Informasi', 2023, '081234567894', 'rudi@example.com', 'Jl. Gajah Mada No. 5', 'Koordinator Divisi', 'Humas', 'Aktif', '2023-09-01'),
('2024.TI.006', 'Putri Ayu', 'P', 'Teknologi Informasi', 2023, '081234567895', 'putri@example.com', 'Jl. Hayam Wuruk No. 6', 'Anggota Divisi', 'Humas', 'Aktif', '2023-09-01'),
('2024.TI.007', 'Andi Wijaya', 'L', 'Teknologi Informasi', 2023, '081234567896', 'andi@example.com', 'Jl. Kemerdekaan No. 7', 'Koordinator Divisi', 'Minat dan Bakat', 'Aktif', '2023-09-01'),
('2024.TI.008', 'Rina Wati', 'P', 'Teknologi Informasi', 2023, '081234567897', 'rina@example.com', 'Jl. Ahmad Yani No. 8', 'Anggota Divisi', 'Minat dan Bakat', 'Aktif', '2023-09-01'),
('2024.TI.009', 'Eko Prasetyo', 'L', 'Teknologi Informasi', 2024, '081234567898', 'eko@example.com', 'Jl. Jendral Sudirman No. 9', 'Anggota Umum', NULL, 'Aktif', '2024-09-01'),
('2024.TI.010', 'Maya Sari', 'P', 'Teknologi Informasi', 2024, '081234567899', 'maya@example.com', 'Jl. Gatot Subroto No. 10', 'Anggota Umum', NULL, 'Aktif', '2024-09-01');
