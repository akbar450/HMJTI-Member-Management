CREATE DATABASE IF NOT EXISTS hmjti_member_management;
USE hmjti_member_management;

-- Table: users
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: anggota
CREATE TABLE IF NOT EXISTS anggota (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    nim VARCHAR(30) NOT NULL UNIQUE,
    angkatan YEAR NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    nomor_hp VARCHAR(20) NOT NULL,
    jabatan ENUM('Ketua', 'Wakil Ketua', 'Sekretaris', 'Bendahara', 'Koor Divisi Humas', 'Anggota Divisi Humas', 'Koor Divisi Minat & Bakat', 'Anggota Divisi Minat & Bakat', 'Anggota Biasa') NOT NULL,
    status ENUM('Aktif', 'Non Aktif') NOT NULL DEFAULT 'Aktif',
    foto VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Seed Data: users (Passwords hashed with password_hash('password', PASSWORD_DEFAULT))
INSERT INTO users (name, email, password, role) VALUES
('Ahmad Rizal', 'admin@hmjti.ac.id', '$2y$10$rBYAyAwws6m0iIYfuBRkoOiEZ69wE1trbw..JP41Eg/fhTJfwo1Qm', 'sekretaris'),
('Budi Santoso', 'ketua@hmjti.ac.id', '$2y$10$rBYAyAwws6m0iIYfuBRkoOiEZ69wE1trbw..JP41Eg/fhTJfwo1Qm', 'ketua')
ON DUPLICATE KEY UPDATE id=id;

-- Seed Data: anggota
INSERT INTO anggota (nama, nim, angkatan, email, nomor_hp, jabatan, status) VALUES
('Budi Santoso', '11203362410001', 2023, 'budi.santoso@hmjti.ac.id', '081234567890', 'Ketua', 'Aktif'),
('Siti Aminah', '11203362410002', 2023, 'siti.aminah@hmjti.ac.id', '081234567891', 'Wakil Ketua', 'Aktif'),
('Ahmad Rizal', '11203362410003', 2023, 'ahmad.rizal@hmjti.ac.id', '081234567892', 'Sekretaris', 'Aktif'),
('Dewi Lestari', '11203362410004', 2023, 'dewi.lestari@hmjti.ac.id', '081234567893', 'Bendahara', 'Aktif'),
('Rudi Heryanto', '11203362410005', 2024, 'rudi.heryanto@hmjti.ac.id', '081234567894', 'Koor Divisi Humas', 'Aktif'),
('Putri Ayu', '11203362410006', 2024, 'putri.ayu@hmjti.ac.id', '081234567895', 'Anggota Divisi Humas', 'Aktif'),
('Andi Wijaya', '11203362410007', 2024, 'andi.wijaya@hmjti.ac.id', '081234567896', 'Koor Divisi Minat & Bakat', 'Aktif'),
('Rina Wati', '11203362410008', 2025, 'rina.wati@hmjti.ac.id', '081234567897', 'Anggota Divisi Minat & Bakat', 'Aktif'),
('Eko Prasetyo', '11203362410009', 2025, 'eko.prasetyo@hmjti.ac.id', '081234567898', 'Anggota Biasa', 'Non Aktif'),
('Maya Sari', '11203362410010', 2026, 'maya.sari@hmjti.ac.id', '081234567899', 'Anggota Biasa', 'Aktif')
ON DUPLICATE KEY UPDATE id=id;
