# Product Requirements Document (PRD)

# HMJTI Member Management

### Sistem Informasi Manajemen Data Anggota HMJTI

---

# Document Information

| Item | Keterangan |
|------|------------|
| Project Name | HMJTI Member Management |
| Version | 1.0 (Final MVP) |
| Status | Final |
| Platform | Android |
| Frontend | Flutter (Dart) |
| Backend | PHP Native REST API |
| Database | MySQL |
| Web Server | Laragon (Apache + MySQL) |
| Document Owner | Suraya Akbar |
| Organization | Himpunan Mahasiswa Jurusan Teknologi Informasi (HMJTI) |
| University | Universitas Sari Mulia |

---

# Revision History

| Version | Date | Author | Description |
|----------|------------|----------------|----------------|
| 1.0 | 05-08-2026 | Suraya Akbar | Final MVP Specification |

---

# 1. Product Overview

## 1.1 Background

HMJTI Member Management merupakan aplikasi mobile berbasis Android yang dirancang untuk membantu pengurus HMJTI Universitas Sari Mulia dalam mengelola data anggota secara terpusat.

Aplikasi ini merupakan implementasi dari hasil Enterprise Architecture HMJTI menggunakan framework TOGAF ADM, khususnya pada Business Architecture dan Information Systems Architecture yang mengidentifikasi kebutuhan terhadap sistem manajemen keanggotaan yang terintegrasi.

Saat ini proses pendataan anggota masih dilakukan menggunakan spreadsheet, dokumen pribadi maupun media komunikasi seperti WhatsApp sehingga mengakibatkan proses administrasi menjadi kurang efektif.

Aplikasi ini dibangun sebagai Minimum Viable Product (MVP) yang hanya berfokus pada modul Manajemen Data Anggota.

---

## 1.2 Business Problem

Permasalahan yang terjadi saat ini meliputi:

- Data anggota masih tersebar pada berbagai media.
- Belum terdapat database terpusat.
- Sulit melakukan pencarian data anggota.
- Terjadi duplikasi data.
- Proses pembaruan data membutuhkan waktu lama.
- Data sering hilang ketika terjadi pergantian kepengurusan.
- Belum tersedia sistem digital untuk pengelolaan anggota.

---

## 1.3 Solution

Solusi yang ditawarkan adalah membangun aplikasi mobile berbasis Flutter yang terhubung dengan REST API menggunakan PHP Native dan MySQL sebagai database utama.

Seluruh proses pengelolaan anggota dilakukan melalui aplikasi sehingga data tersimpan secara terpusat dan mudah diakses oleh pengurus yang memiliki hak akses.

---

# 2. Product Goals

Pengembangan aplikasi bertujuan untuk:

- Membangun sistem manajemen anggota berbasis mobile.
- Menyediakan database anggota yang terpusat.
- Mempermudah pengelolaan data anggota.
- Mengurangi penggunaan spreadsheet manual.
- Mendukung transformasi digital HMJTI.
- Menjadi implementasi Enterprise Architecture HMJTI.

---

# 3. Objectives

Aplikasi harus mampu:

- Menampilkan dashboard statistik.
- Menampilkan seluruh anggota.
- Menambahkan anggota baru.
- Mengubah data anggota.
- Menghapus data anggota.
- Menampilkan detail anggota.
- Melakukan pencarian data anggota.
- Melakukan filter data anggota.
- Login pengguna (Ketua & Sekretaris).
- Logout pengguna.

---

# 4. Project Scope

## 4.1 Included (MVP)

### Authentication
- Login (Menggunakan akun yang dibuat oleh Administrator Sistem di MySQL)
- Logout

### Dashboard
- Statistik anggota (Total Anggota, Total Pengurus, Total Angkatan, Total Anggota Aktif)
- Menu navigasi cepat

### Manajemen Data Anggota
- List anggota
- Detail anggota
- Tambah anggota
- Edit anggota
- Hapus anggota

### Search
- Realtime search berdasarkan Nama dan NIM

### Filter
- Filter berdasarkan Angkatan, Jabatan, dan Status

### Profile
- Profil pengguna singkat (Nama & Role)
- Informasi aplikasi

---

## 4.2 Out of Scope

Fitur berikut tidak termasuk dalam versi MVP dan dilarang diimplementasikan pada versi ini:

- Register / Pendaftaran Akun Mandiri
- Forgot Password / Lupa Password
- Change Password / Ubah Password
- CRUD User / Manajemen Akun Pengguna
- Presensi / Absensi QR Code
- Push Notification
- Export PDF & Excel
- Firebase & Realtime DB
- Chat & Messaging
- Program Kerja & Kepanitiaan
- Arsip Dokumen & Surat Menyurat
- Inventaris & LPJ

---

# 5. Stakeholder

| Stakeholder | Peran |
|--------------|-------------------------------|
| Ketua HMJTI | Pengguna sistem & Sponsor proyek |
| Sekretaris HMJTI | Pengguna sistem & Administrator data anggota |
| Pengurus HMJTI | Pengguna sistem |
| Mahasiswa TI | Penerima manfaat tidak langsung |
| Developer | Pengembang aplikasi |

---

# 6. User Persona

## Persona 1

**Nama**: Sekretaris HMJTI

**Deskripsi**: Bertanggung jawab mengelola administrasi organisasi dan seluruh data anggota.

**Goals**:
- Mengelola data anggota (CRUD).
- Memastikan data selalu terbaru dan akurat.
- Mempermudah pencarian anggota.

**Pain Points**:
- Spreadsheet manual sulit dikelola.
- Data tersebar di banyak tempat.
- Sulit mencari data alumni/anggota lama.

---

## Persona 2

**Nama**: Ketua HMJTI

**Deskripsi**: Memerlukan informasi anggota secara cepat untuk mendukung pengambilan keputusan dan analisis organisasi.

**Goals**:
- Melihat statistik ringkas anggota di Dashboard.
- Melihat detail data anggota.

**Pain Points**:
- Data tidak terpusat.
- Sulit memperoleh informasi terbaru secara realtime.

---

# 7. User Stories

| ID | User Story | Priority |
|----|------------|----------|
| US-01 | Sebagai Sekretaris/Ketua saya ingin login menggunakan email & password dari admin sehingga dapat mengakses aplikasi. | High |
| US-02 | Sebagai Sekretaris/Ketua saya ingin melihat seluruh anggota dalam daftar sehingga dapat mengantisipasi kebutuhan informasi. | High |
| US-03 | Sebagai Sekretaris/Ketua saya ingin menambah data anggota baru sehingga database terpusat selalu up-to-date. | High |
| US-04 | Sebagai Sekretaris/Ketua saya ingin mengedit data anggota sehingga informasi selalu akurat. | High |
| US-05 | Sebagai Sekretaris/Ketua saya ingin menghapus data anggota yang salah sehingga data tetap valid. | High |
| US-06 | Sebagai Ketua/Sekretaris saya ingin melihat statistik dashboard sehingga mengetahui kondisi keanggotaan. | High |
| US-07 | Sebagai Ketua/Sekretaris saya ingin mencari anggota berdasarkan Nama/NIM secara realtime. | Medium |
| US-08 | Sebagai Ketua/Sekretaris saya ingin memfilter anggota berdasarkan Angkatan, Jabatan, dan Status. | Medium |
| US-09 | Sebagai Ketua/Sekretaris saya ingin logout dari aplikasi untuk menjaga keamanan akses. | High |

---

# 8. Functional Requirements

## 8.1 Authentication

### Login
- **Deskripsi**: Pengguna melakukan autentikasi masuk menggunakan email dan password.
- **Ketentuan**: Akun pengguna dibuat oleh Administrator Sistem saat implementasi awal langsung melalui database MySQL. User tidak dapat membuat akun sendiri (Register tidak ada).
- **Alur Process**:
  `Flutter Form` -> `HTTP POST /login` -> `PHP Native Backend (PDO & password_verify)` -> `MySQL Query` -> `JSON Response` -> `Save Login Status, Name, Role to Shared Preferences` -> `Navigate to DashboardScreen`

### Logout
- **Deskripsi**: Menghapus session lokal pengguna dari Shared Preferences (Login Status, User Name, User Role) dan melakukan navigasi kembali ke halaman LoginScreen.

---

## 8.2 Dashboard

- **Statistik Ringkas**:
  - Total Anggota
  - Total Pengurus
  - Total Angkatan
  - Total Anggota Aktif
- **Navigasi Cepat**:
  - Data Anggota (ListScreen)
  - Profile Screen
  - Tombol Logout

---

## 8.3 Modul Manajemen Data Anggota

### 8.3.1 List Anggota
- Menampilkan seluruh data anggota HMJTI dalam daftar (ListView).
- Menampilkan foto profil (jika ada), nama, NIM, angkatan, jabatan, dan status.
- Dilengkapi Search Bar, Filter Sheet, Floating Action Button (Tambah Anggota), dan Pull to Refresh.

### 8.3.2 Detail Anggota
- Menampilkan informasi lengkap anggota (Foto, Nama, NIM, Angkatan, Email, Nomor HP, Jabatan, Status, Created At, Updated At).
- Memiliki aksi tombol Edit Anggota dan Hapus Anggota.

### 8.3.3 Tambah Anggota
- Mengisi form: Nama, NIM, Angkatan, Email, Nomor HP, Jabatan (Dropdown), Status (Dropdown), Foto (Opsional/File Picker).
- Validasi input di Flutter & Server -> POST ke REST API -> Simpan ke MySQL -> Response JSON -> Toast/Snackbar sukses -> Refresh List.

### 8.3.4 Edit Anggota
- Form terisi otomatis dengan data anggota terpilih.
- Mengirim update ke REST API (`PUT /anggota/{id}`) -> Response JSON -> Refresh Data.

### 8.3.5 Hapus Anggota
- Menampilkan Dialog konfirmasi ("Apakah Anda yakin ingin menghapus anggota ini?").
- Jika dikonfirmasi, kirim request `DELETE /anggota/{id}` -> Tampilkan Snackbar sukses -> Kembali ke List.

---

## 8.4 Search

- Pencarian realtime pada List Anggota.
- Kriteria pencarian: `nama` atau `nim`.
- Case-insensitive (tidak membedakan huruf besar dan kecil).

---

## 8.5 Filter

- Dapat diterapkan secara individual maupun kombinasi.
- Kriteria filter:
  - Angkatan (e.g. 2023, 2024, 2025, 2026)
  - Jabatan (Ketua, Wakil Ketua, Sekretaris, Bendahara, Koordinator Divisi, Anggota)
  - Status (Aktif, Non Aktif)

---

## 8.6 Sorting

- Default: Nama (A-Z)
- Pilihan lain: Nama (Z-A), Angkatan Terbaru, Angkatan Terlama.

---

# 9. Business Rules

## Authentication & User Management
- Hanya ada 2 role pengguna: `ketua` dan `sekretaris`.
- Pada versi MVP ini, kedua role (`ketua` dan `sekretaris`) memiliki hak akses (permissions) yang sama persis untuk seluruh fitur (Login, Dashboard, View, Add, Edit, Delete Anggota, Search, Filter, Logout).
- Role saat ini hanya difungsikan sebagai identitas pengguna. Role-Based Access Control (RBAC) granular akan diterapkan pada versi mendatang.
- Akun pengguna diisi manual oleh Administrator Sistem di MySQL saat instalasi awal. Tidak ada fitur pendaftaran akun (Register) maupun manajemen akun (CRUD User).

## Data Anggota
- `nama`: Wajib diisi.
- `nim`: Wajib diisi dan harus unik.
- `email`: Wajib diisi dan harus unik.
- `nomor_hp`: Wajib diisi.
- `foto`: Opsional. Hanya menyimpan string berupa nama file gambar atau URL. File fisik disimpan dalam folder `uploads/` pada backend.

## Status Options
- Aktif
- Non Aktif

## Jabatan Options
- Ketua
- Wakil Ketua
- Sekretaris
- Bendahara
- Koor Divisi Humas
- Anggota Divisi Humas
- Koor Divisi Minat & Bakat
- Anggota Divisi Minat & Bakat
- Anggota Biasa

## Angkatan Format
- Format 4 digit tahun (YYYY), contoh: 2023, 2024, 2025, 2026.

---

# 10. Validation Rules

| Field | Rule Validasi |
|-------|---------------|
| Nama | Wajib, min 3 karakter, max 100 karakter |
| NIM | Wajib, unik, max 30 karakter |
| Email | Wajib, format email valid, unik, max 100 karakter |
| Nomor HP | Wajib, min 10 digit, max 15 digit, angka |
| Jabatan | Wajib memilih salah satu opsi valid |
| Status | Wajib memilih salah satu opsi valid |

---

# 11. Non Functional Requirements

| Aspek | Requirement | Target |
|--------|-------------|---------|
| Performance | Response REST API | < 2 detik |
| Performance | Loading Dashboard | < 2 detik |
| Security | Validasi seluruh input di Backend | 100% |
| Security | Prepared Statement (PDO) | Wajib pada semua query |
| Security | Password Hash | password_hash() & password_verify() |
| Security | Protection | Bebas SQL Injection & XSS |
| Compatibility | Operating System | Android 8.0+ (API Level 26+) |
| Availability | REST API | 24/7 (Server Laragon/Local) |
| Reliability | Response Format | JSON konsisten |
| Maintainability | Code Style | Clean Code & Reusable Component |

---

# 12. UI/UX Guidelines

- **Design System**: Material Design 3 (M3).
- **Typography**: Poppins (via google_fonts atau lokal asset).
- **Primary Color**: Merah Tua (`#B71C1C`).
- **Secondary Color**: Kuning Keemasan (`#FFD700`).
- **Border Radius**: 16 px (pada Card, Dialog, Input Decorator, dan Button).
- **Button**: Material 3 FilledButton & OutlinedButton.
- **Floating Action Button**: Digunakan untuk aksi utama Tambah Anggota.
- **Snackbar**: Digunakan untuk umpan balik notifikasi (Sukses/Gagal/Error API).
- **Dialog**: Konfirmasi hapus data dan dialog konfirmasi logout.
- **Empty State**: Menampilkan ilustrasi/ikon + pesan "Belum ada data anggota." ketika data kosong.

---

# 13. Error Handling

- **HTTP Status Code Standard**:
  - `200 OK`: Request berhasil diproses.
  - `201 Created`: Data anggota baru berhasil dibuat.
  - `400 Bad Request`: Validasi input gagal / data tidak lengkap.
  - `401 Unauthorized`: Email/password salah atau belum terautentikasi.
  - `404 Not Found`: Endpoint atau data ID tidak ditemukan.
  - `500 Internal Server Error`: Kesalahan server / database failure.

- **Flutter Error Handling Rules**:
  - SELURUH request HTTP API pada Flutter WAJIB dibungkus dengan block `try-catch`.
  - Tangani exception spesifik seperti `SocketException` (koneksi jaringan) dan `FormatException` (parsing JSON).
  - Tampilkan pesan yang ramah pengguna via Snackbar/Dialog (misalnya "Gagal terhubung ke server", "Periksa koneksi internet Anda").
  - Aplikasi DILARANG Force Close (crash) dalam kondisi error apa pun.

---

# 14. Technical Architecture

## 14.1 Technology Stack

| Layer | Technology |
|--------|------------|
| Frontend Framework | Flutter 3.x (Dart) |
| Frontend Architecture | Provider State Management |
| HTTP Client | http package |
| UI Design System | Material Design 3 |
| Local Storage | Shared Preferences (Status, Name, Role saja) |
| Backend Framework | PHP Native (No Framework/No Laravel) |
| Database Engine | MySQL (via PDO Prepared Statement) |
| Web Server | Laragon (Apache) |
| Data Format | JSON (Application/json) |

---

## 14.2 System Architecture

```text
+-----------------------------------+
|       Flutter Mobile App          |
| (UI, Provider, Services, HTTP)    |
+-----------------------------------+
                  │
                  │ HTTP Request (JSON)
                  ▼
+-----------------------------------+
|      PHP Native REST API          |
| (Controllers, Routes, Models, PDO)|
+-----------------------------------+
                  │
                  │ Prepared Statement Query
                  ▼
+-----------------------------------+
|         MySQL Database            |
| (Tables: users, anggota)          |
+-----------------------------------+
```

Flutter bertindak sebagai Client murni. Flutter DILARANG terhubung langsung ke database MySQL. SELURUH komunikasi data wajib melalui REST API berformat JSON.

---

## 14.3 Folder Structure Flutter

```text
lib/
├── core/
│   ├── config/
│   ├── constants/
│   └── theme/
├── models/
├── services/
├── providers/
├── screens/
│   ├── auth/
│   ├── dashboard/
│   ├── anggota/
│   └── profile/
├── widgets/
├── utils/
└── main.dart
```

---

## 14.4 Folder Structure Backend

```text
config/
controllers/
models/
routes/
helpers/
uploads/
database/
index.php
```

---

# 15. Database Design

## Database Name
`hmjti_member_management`

---

## Table: users

Digunakan khusus untuk autentikasi login pengurus.

| Field | Type | Constraint | Keterangan |
|--------|------|------------|------------|
| id | BIGINT | PRIMARY KEY AUTO_INCREMENT | ID unik user |
| name | VARCHAR(100) | NOT NULL | Nama pengurus |
| email | VARCHAR(100) | UNIQUE NOT NULL | Email untuk login |
| password | VARCHAR(255) | NOT NULL | Password ter-hash (password_hash) |
| role | VARCHAR(20) | NOT NULL | Opsi: 'ketua', 'sekretaris' |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Waktu dibuat |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Waktu diubah |

*Catatan: Akun dibuat oleh Administrator Sistem saat instalasi awal melalui database MySQL. User tidak dapat membuat akun sendiri.*

---

## Table: anggota

Digunakan untuk menyimpan seluruh data anggota HMJTI.

| Field | Type | Constraint | Keterangan |
|--------|------|------------|------------|
| id | BIGINT | PRIMARY KEY AUTO_INCREMENT | ID unik anggota |
| nama | VARCHAR(100) | NOT NULL | Nama lengkap anggota |
| nim | VARCHAR(30) | UNIQUE NOT NULL | Nomor Induk Mahasiswa |
| angkatan | YEAR | NOT NULL | Tahun angkatan (YYYY) |
| email | VARCHAR(100) | UNIQUE NOT NULL | Email mahasiswa |
| nomor_hp | VARCHAR(20) | NOT NULL | Nomor WhatsApp/HP |
| jabatan | ENUM('Ketua','Wakil Ketua','Sekretaris','Bendahara','Koor Divisi Humas','Anggota Divisi Humas','Koor Divisi Minat & Bakat','Anggota Divisi Minat & Bakat','Anggota Biasa') | NOT NULL | Jabatan di HMJTI |
| status | ENUM('Aktif','Non Aktif') | NOT NULL | Status keanggotaan |
| foto | VARCHAR(255) | NULL | Nama file foto atau URL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Waktu data dibuat |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Waktu data diubah |

*Catatan: Field `foto` hanya menyimpan string nama file atau URL. File gambar diunggah dan disimpan dalam direktori `uploads/` pada backend server.*

---

# 16. API Specification

Seluruh endpoint REST API wajib menggunakan header `Content-Type: application/json` dan mengembalikan respon JSON konsisten.

Base URL:
`http://localhost/hmjti_api/api/` (atau IP lokal host untuk pengujian Android Emulator / Physical Device).

---

## 16.1 POST /login

- **Tujuan**: Otentikasi pengurus (Ketua / Sekretaris) untuk masuk ke dalam aplikasi.
- **Request Header**: `Content-Type: application/json`
- **Request Body**:
```json
{
  "email": "admin@hmjti.ac.id",
  "password": "password123"
}
```
- **Response Success (200 OK)**:
```json
{
  "success": true,
  "message": "Login berhasil",
  "data": {
    "user": {
      "id": 1,
      "name": "Sekretaris HMJTI",
      "email": "admin@hmjti.ac.id",
      "role": "sekretaris"
    }
  }
}
```
- **HTTP Status Code**:
  - `200 OK`: Autentikasi berhasil.
  - `400 Bad Request`: Email atau password belum diisi.
  - `401 Unauthorized`: Email atau password salah.
  - `500 Internal Server Error`: Kesalahan server/database.
- **Kemungkinan Error**: Form kosong, user tidak ditemukan, password tidak cocok.

---

## 16.2 POST /logout

- **Tujuan**: Mengakhiri sesi login pengurus pada server/aplikasi.
- **Request Header**: `Content-Type: application/json`
- **Request Body**: `{}`
- **Response Success (200 OK)**:
```json
{
  "success": true,
  "message": "Logout berhasil"
}
```
- **HTTP Status Code**:
  - `200 OK`: Logout berhasil.
- **Kemungkinan Error**: None.

---

## 16.3 GET /dashboard

- **Tujuan**: Mengambil data statistik akumulatif untuk ditampilkan di DashboardScreen.
- **Request Header**: `Content-Type: application/json`
- **Request Body**: None
- **Response Success (200 OK)**:
```json
{
  "success": true,
  "message": "Data dashboard berhasil dimuat",
  "data": {
    "total_anggota": 120,
    "total_pengurus": 25,
    "total_angkatan": 4,
    "anggota_aktif": 118
  }
}
```
- **HTTP Status Code**:
  - `200 OK`: Data statistik berhasil diambil.
  - `500 Internal Server Error`: Gagal menghitung agregat database.
- **Kemungkinan Error**: Kegagalan query agregasi database.

---

# 17. API Anggota

## 17.1 GET /anggota

- **Tujuan**: Mengambil seluruh daftar anggota (mendukung query parameter `search`, `angkatan`, `jabatan`, `status`).
- **Request Header**: `Content-Type: application/json`
- **Query Parameters (Opsional)**: `?search=akbar&angkatan=2025&status=Aktif`
- **Response Success (200 OK)**:
```json
{
  "success": true,
  "message": "Data anggota berhasil dimuat",
  "data": [
    {
      "id": 1,
      "nama": "Suraya Akbar",
      "nim": "11203362410132",
      "angkatan": "2025",
      "email": "akbar@gmail.com",
      "nomor_hp": "081234567890",
      "jabatan": "Ketua",
      "status": "Aktif",
      "foto": "uploads/akbar.jpg",
      "created_at": "2026-08-05 10:00:00",
      "updated_at": "2026-08-05 10:00:00"
    }
  ]
}
```
- **HTTP Status Code**:
  - `200 OK`: Data berhasil dimuat.
  - `500 Internal Server Error`: Gagal mengambil data database.
- **Kemungkinan Error**: Error koneksi database.

---

## 17.2 GET /anggota/{id}

- **Tujuan**: Mengambil detail lengkap satu anggota berdasarkan ID.
- **Request Header**: `Content-Type: application/json`
- **Response Success (200 OK)**:
```json
{
  "success": true,
  "message": "Detail anggota berhasil dimuat",
  "data": {
    "id": 1,
    "nama": "Suraya Akbar",
    "nim": "11203362410132",
    "angkatan": "2025",
    "email": "akbar@gmail.com",
    "nomor_hp": "081234567890",
    "jabatan": "Ketua",
    "status": "Aktif",
    "foto": "uploads/akbar.jpg",
    "created_at": "2026-08-05 10:00:00",
    "updated_at": "2026-08-05 10:00:00"
  }
}
```
- **HTTP Status Code**:
  - `200 OK`: Data ditemukan.
  - `404 Not Found`: Anggota dengan ID tersebut tidak ditemukan.
  - `500 Internal Server Error`: Kesalahan server.
- **Kemungkinan Error**: ID tidak valid atau data dihapus.

---

## 17.3 POST /anggota

- **Tujuan**: Menambahkan data anggota baru ke sistem.
- **Request Header**: `Content-Type: application/json` (atau multipart/form-data jika mengunggah file foto)
- **Request Body**:
```json
{
  "nama": "Suraya Akbar",
  "nim": "11203362410132",
  "angkatan": "2025",
  "email": "akbar@gmail.com",
  "nomor_hp": "081234567890",
  "jabatan": "Anggota",
  "status": "Aktif",
  "foto": null
}
```
- **Response Success (201 Created)**:
```json
{
  "success": true,
  "message": "Data anggota berhasil ditambahkan",
  "data": {
    "id": 1
  }
}
```
- **HTTP Status Code**:
  - `201 Created`: Anggota berhasil ditambahkan.
  - `400 Bad Request`: Validasi input gagal (NIM/Email sudah terdaftar, field wajib kosong).
  - `500 Internal Server Error`: Gagal insert ke database.
- **Kemungkinan Error**: NIM duplikat, Email duplikat, format input salah.

---

## 17.4 PUT /anggota/{id}

- **Tujuan**: Mengubah/memperbarui data anggota yang sudah ada.
- **Request Header**: `Content-Type: application/json`
- **Request Body**:
```json
{
  "nama": "Suraya Akbar Revised",
  "nim": "11203362410132",
  "angkatan": "2025",
  "email": "akbar_new@gmail.com",
  "nomor_hp": "081234567890",
  "jabatan": "Ketua",
  "status": "Aktif",
  "foto": "uploads/akbar.jpg"
}
```
- **Response Success (200 OK)**:
```json
{
  "success": true,
  "message": "Data anggota berhasil diperbarui"
}
```
- **HTTP Status Code**:
  - `200 OK`: Data berhasil diperbarui.
  - `400 Bad Request`: Validasi gagal atau NIM/Email bentrok dengan anggota lain.
  - `404 Not Found`: ID anggota tidak ditemukan.
  - `500 Internal Server Error`: Gagal update ke database.
- **Kemungkinan Error**: ID tidak valid, duplikasi NIM/Email milik orang lain.

---

## 17.5 DELETE /anggota/{id}

- **Tujuan**: Menghapus data anggota tertentu dari database.
- **Request Header**: `Content-Type: application/json`
- **Response Success (200 OK)**:
```json
{
  "success": true,
  "message": "Data anggota berhasil dihapus"
}
```
- **HTTP Status Code**:
  - `200 OK`: Data berhasil dihapus.
  - `404 Not Found`: ID anggota tidak ditemukan.
  - `500 Internal Server Error`: Gagal delete dari database.
- **Kemungkinan Error**: ID tidak valid.

---

# 18. Dashboard API

(Sudah terdokumentasikan secara lengkap pada poin 16.3 POST/GET /dashboard).

---

# 19. JSON Response Standard

## Standard Success Response
```json
{
  "success": true,
  "message": "Deskripsi pesan sukses",
  "data": {}
}
```

## Standard Error Response
```json
{
  "success": false,
  "message": "Deskripsi kesalahan / pesan error"
}
```

---

# 20. Shared Preferences

Shared Preferences pada aplikasi Flutter HANYA BOLEH digunakan untuk menyimpan data sesi berikut:

1. **Login Status** (`isLoggedIn`: `bool`)
2. **User Name** (`userName`: `String`)
3. **User Role** (`userRole`: `String`)

*Peringatan Ketat*: Dilarang menyimpan data anggota, daftar anggota, password, atau data sensitif lainnya ke dalam Shared Preferences.

---

# 21. Security

## Prepared Statement
Seluruh query ke MySQL pada PHP Native WAJIB menggunakan `PDO Prepared Statement` dengan bound parameters (`bindValue` / `bindParam`) untuk menjamin keamanan dari serangan **SQL Injection**.

## Input Validation
Semua data masukan dari client harus divalidasi dan disanitasi di layer PHP Backend sebelum diproses oleh database.

## Password Hashing
Password user disimpan menggunakan fungsi bawaan PHP `password_hash($password, PASSWORD_BCRYPT)` dan diverifikasi menggunakan `password_verify($password, $hash)`.

## Safe Response
Response API tidak boleh menyertakan password hash user.

## Stateless REST Protocol
Rest API mengembalikan status sukses atau error melalui JSON response standard. JWT / OAuth dilarang diimplementasikan pada versi MVP ini demi menyederhanakan arsitektur MVP.

---

# 22. Project Structure

## Flutter Project

```text
lib/
├── core/
│   ├── config/
│   ├── constants/
│   └── theme/
├── models/
├── services/
├── providers/
├── screens/
│   ├── auth/
│   ├── dashboard/
│   ├── anggota/
│   └── profile/
├── widgets/
├── utils/
└── main.dart
```

## Backend Project

```text
config/
controllers/
models/
routes/
helpers/
uploads/
database/
index.php
```

---

# 23. Development Workflow

1. **Phase 1: Backend Setup & API Development**:
   - Pembuatan Database `hmjti_member_management` & Tabel (`users`, `anggota`) di MySQL via Laragon.
   - Pembuatan skema folder backend PHP Native.
   - Implementasi PDO connection, Helpers, Controllers, Routes, dan Handlers.
   - Pengujian seluruh endpoint API menggunakan Postman.

2. **Phase 2: Flutter Foundation & Authentication**:
   - Inisialisasi project Flutter dengan Material Design 3.
   - Implementasi Core (Theme, Constants, Config).
   - Implementasi AuthProvider, MemberService, dan Shared Preferences helper.
   - Pembuatan LoginScreen & DashboardScreen.

3. **Phase 3: Modul Manajemen Data Anggota**:
   - Pembuatan MemberModel, MemberProvider, dan MemberService CRUD methods.
   - Pembuatan ListAnggotaScreen, DetailAnggotaScreen, FormAnggotaScreen (Tambah & Edit).
   - Integrasi dialog konfirmasi hapus data.

4. **Phase 4: Search, Filter, & Polish**:
   - Integrasi realtime search & filter di ListAnggotaScreen.
   - Integrasi Pull-to-Refresh & Empty State widget.
   - Penanganan Error try-catch & Snackbar notifikasi.

5. **Phase 5: Testing & Verification**:
   - Pengujian fungsionalitas end-to-end (Flutter -> REST API -> MySQL).
   - Pemastian kesesuaian tampilan M3 & respon aplikasi.

---

# 24. Coding Convention

## Bahasa & Naming Rules
- **Bahasa**: Gunakan Bahasa Inggris untuk penamaan Class, Method, Variable, Function, Folder, dan File. Gunakan Bahasa Indonesia hanya pada antarmuka teks UI pengguna.
- **Class / Component / Enum**: `PascalCase` (Contoh: `MemberModel`, `DashboardScreen`, `MemberProvider`).
- **Variable / Function / Method**: `camelCase` (Contoh: `memberName`, `fetchMemberList()`, `isLoading`).
- **Constant**: `UPPER_CASE` (Contoh: `BASE_URL`, `PRIMARY_COLOR`).
- **Modifiers**: Gunakan `const` dan `final` secara tepat.
- **Dart Safety**: Wajib menerapkan Sound Null Safety.

## Clean Code & Refactoring Rules
- **Hindari Duplicate Code**: Terapkan prinsip DRY (Don't Repeat Yourself).
- **Reusable Widget**: Komponen UI yang digunakan lebih dari satu kali (seperti Input Field, Button, Member Card) WAJIB dibuat sebagai terpisah di folder `widgets/`.
- **Modulize Widgets**: Pisahkan Build Method yang besar/panjang menjadi widget-widget kecil terspesialisasi.

---

# 25. Performance Requirement

| Aktivitas | Target Performa |
|------------|-----------------|
| Login Request | < 2 detik |
| Loading Dashboard | < 2 detik |
| Response Operations (CRUD) | < 2 detik |
| Realtime Search | Instant / < 500ms |
| Filter Data | < 1 detik |

---

# 26. Security Requirement

- Backend WAJIB menggunakan:
  - PDO Prepared Statements
  - Input Validation & Sanitization
  - `password_hash()` & `password_verify()`
  - Restful JSON Response
- Flutter WAJIB:
  - Dilarang menyimpan password dalam bentuk apa pun.
  - Menyimpan status login, nama, dan role saja di Shared Preferences.
  - Dilarang menyimpan data anggota secara lokal di perangkat.

---

# 27. Definition of Done (DoD)

Fitur dinyatakan selesai apabila:
- Login & Logout berfungsi menggunakan REST API & Shared Preferences.
- Dashboard menampilkan statistik akurat secara realtime dari MySQL.
- CRUD data anggota berfungsi penuh tanpa bug.
- Realtime Search dan Kombinasi Filter berjalan akurat.
- Data tersimpan dan diperbarui di MySQL secara permanen.
- Tidak ada crash / Force Close pada Flutter (`try-catch` terpasang di semua Service/Provider API call).
- Bebas dari SQL Injection dan error 500 server.

---

# 28. Future Development

Versi berikutnya dapat dikembangkan untuk mencakup modul tambahan:
- Program Kerja & Kepanitiaan Organisasi
- Presensi & Absensi QR Code
- Arsip Dokumen & Surat Menyurat Digital
- Inventaris & Laporan Pertanggungjawaban (LPJ)
- Agenda & Kalender Kegiatan Organisasi
- Push Notification
- Export Data Anggota ke PDF & Excel
- Granular Role-Based Access Control (RBAC)
- Multi Organisasi & Integrasi Web Portal HMJTI

---

# 29. Risk Management

| Risiko | Dampak | Mitigasi |
|---------|---------|-----------|
| Server Laragon/MySQL Mati | Tinggi | Pastikan Apache & MySQL Service aktif sebelum menjalankan aplikasi. |
| API Unreachable / Timeout | Tinggi | Validasi Base URL & koneksi IP lokal, tangani error via try-catch di Flutter. |
| Duplikasi Data (NIM/Email) | Sedang | Validasi UNIQUE constraint di MySQL dan validasi di controller PHP Backend. |
| SQL Injection | Tinggi | Menggunakan PDO Prepared Statement 100% pada semua database query. |
| Kesalahan Form Input | Sedang | Validasi Form di Flutter (client-side) dan di PHP (server-side). |

---

# 30. Assumption

- Environment Laragon (Apache + MySQL) sudah dikonfigurasi.
- Port web server PHP REST API dapat diakses oleh Emulator Android / Physical Device.
- Database `hmjti_member_management` telah diimpor dan terisi akun admin di tabel `users`.
- Aplikasi Flutter berjalan di atas SDK Flutter versi 3.x stable.

---

# 31. Testing Strategy

## Backend Testing
- Postman Collection untuk menguji seluruh endpoint REST API (`/login`, `/logout`, `/dashboard`, `/anggota`).
- Pengujian skenario sukses (200/201) dan skenario error (400/401/404/500).

## Flutter Testing
- Form validation testing.
- UI & Integration testing (Login -> Dashboard -> List -> CRUD -> Filter/Search -> Logout).
- Edge-case network failure testing.

---

# 32. AI Coding Rules

Dokumen PRD ini adalah **SINGLE SOURCE OF TRUTH** untuk seluruh pengembangan project. AI Coding Assistant WAJIB mematuhi seluruh aturan berikut:

## AI WAJIB:
1. Mengikuti dan mematuhi seluruh isi, spesifikasi, dan arsitektur yang tertulis di PRD ini.
2. Menggunakan **Provider** sebagai state management tunggal aplikasi Flutter.
3. Menggunakan **REST API** untuk seluruh komunikasi data antara Flutter dan Backend.
4. Menggunakan package resmi **`http`** untuk HTTP client di Flutter.
5. Menggunakan **Material Design 3 (M3)** untuk seluruh komponen UI dan tema Flutter.
6. Menghasilkan kode yang **reusable**, modular, dan efisien (DRY).
7. Menghasilkan **clean code**, terstruktur, dengan penamaan yang sesuai dengan convention.
8. Mempertahankan **struktur folder** Flutter dan Backend secara ketat sesuai PRD.

## AI DILARANG:
1. Membuat fitur **Register** / Pendaftaran akun.
2. Membuat fitur **Forgot Password** / Lupa Password.
3. Membuat fitur **Change Password** / Ubah Password.
4. Membuat fitur **CRUD User** / Manajemen Pengguna.
5. Menghubungkan Flutter **langsung ke MySQL** (harus selalu lewat REST API).
6. Mengubah **nama/path endpoint** REST API.
7. Mengubah **nama tabel** atau **nama field** database MySQL.
8. Mengubah atau mengacak-acak **struktur folder** yang telah ditetapkan.
9. Membuat fitur tambahan **di luar ruang lingkup MVP** yang ditentukan.

---

# 33. Acceptance Criteria

Aplikasi dinyatakan selesai apabila:
- Login & Logout berhasil terhubung dengan REST API.
- Dashboard menampilkan statistik riil dari MySQL.
- CRUD anggota berfungsi 100% tanpa kendala.
- Search dan Filter berjalan lancar.
- Data tersimpan presisi di MySQL via REST API.
- UI bersih dan konsisten berbasis Material Design 3.
- Penanganan error teruji (`try-catch` aktif) sehingga tidak ada force close.
- Seluruh endpoint REST API memenuhi spesifikasi JSON Standard.

---

# 34. Conclusion

HMJTI Member Management merupakan implementasi awal dari Enterprise Architecture HMJTI yang berfokus pada digitalisasi pengelolaan data anggota. Aplikasi ini dibangun menggunakan Flutter sebagai frontend, PHP Native sebagai backend REST API, dan MySQL sebagai basis data terpusat. Seluruh proses pengembangan mengikuti prinsip modular, terstruktur, dan mudah dikembangkan sehingga dapat menjadi fondasi bagi pengembangan Sistem Informasi HMJTI yang lebih komprehensif pada fase berikutnya.
