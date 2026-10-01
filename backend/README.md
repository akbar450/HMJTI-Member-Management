# 🚀 HMJTI Member Management API

Dokumentasi RESTful API untuk sistem manajemen anggota **Himpunan Mahasiswa Jurusan Teknologi Informasi (HMJTI)**. API ini dibangun menggunakan **PHP Native (PDO)** dengan arsitektur MVC (Model-View-Controller) yang bersih, modular, dan terstruktur.

---

## 📌 Daftar Isi
- [Fitur Utama](#-fitur-utama)
- [Teknologi & Persyaratan](#-teknologi--persyaratan)
- [Struktur Direktori Proyek](#-struktur-direktori-proyek)
- [Instalasi & Pengaturan](#-instalasi--pengaturan)
- [Konfigurasi Database](#-konfigurasi-database)
- [Format Respon Standar](#-format-respon-standar)
- [Dokumentasi API Endpoint](#-dokumentasi-api-endpoint)
  - [1. Autentikasi (Auth)](#1-autentikasi-auth)
  - [2. Dashboard & Statistik](#2-dashboard--statistik)
  - [3. Manajemen Anggota (Anggota)](#3-manajemen-anggota-anggota)
- [Aturan Validasi Data](#-aturan-validasi-data)
- [Skema Database](#-skema-database)

---

## ✨ Fitur Utama
- 🔐 **Autentikasi User**: Login dan Logout administrator dengan token sesi.
- 📊 **Statistik Dashboard**: Ringkasan jumlah total anggota, pengurus, angkatan, dan anggota aktif.
- 👥 **Manajemen Anggota (CRUD)**:
  - Pencarian anggota berdasarkan **Nama** atau **NIM**.
  - Filter data berdasarkan **Angkatan**, **Jabatan**, dan **Status**.
  - Pengurutan data (Sorting) A-Z, Z-A, Angkatan Terbaru, dan Angkatan Terlama.
- 🖼️ **Upload Foto Profil**: Mendukung pengunggahan foto profil anggota (`multipart/form-data`).
- 🌐 **Dukungan CORS & Header Json**: Penanganan Cross-Origin Resource Sharing secara fleksibel.

---

## 🛠️ Teknologi & Persyaratan

### Teknologi:
- **Bahasa Pemrograman**: PHP 7.4+ / PHP 8.x
- **Database**: MySQL / MariaDB
- **Driver Database**: PHP Data Objects (PDO)
- **Web Server**: Apache (`mod_rewrite` aktif) / Nginx / Laragon / XAMPP

### Persyaratan Sistem:
- PHP versi `^7.4` atau `^8.0`
- Ekstensi PHP yang dibutuhkan: `pdo`, `pdo_mysql`, `json`

---

## 📂 Struktur Direktori Proyek

```text
hmjti_api/
├── api/                        # Endpoint file opsional / pendukung
│   ├── anggota.php
│   ├── dashboard.php
│   ├── login.php
│   ├── logout.php
│   ├── members/                # Sub-endpoint standar
│   └── stats/
├── config/                     # Konfigurasi sistem
│   ├── cors.php                # Penanganan CORS Header
│   └── database.php            # Koneksi Database PDO
├── controllers/                # Logic Pengendali Request (MVC)
│   ├── AnggotaController.php
│   ├── AuthController.php
│   └── DashboardController.php
├── database/                   # Skrip & Migrasi Database
│   └── hmjti_member_management.sql
├── helpers/                    # Helper universal
│   └── Response.php            # Formatter standar JSON Response
├── models/                     # Model Query Database (MVC)
│   ├── Anggota.php
│   └── User.php
├── routes/                     # Central Router API
│   └── api.php                 # Map HTTP Request ke Controller
├── uploads/                    # Direktori penyimpanan foto profil unggahan
├── .htaccess                   # Rewrite URL ke index.php
├── index.php                   # Entry point utama API
└── README.md                   # Dokumentasi API
```

---

## ⚙️ Instalasi & Pengaturan

1. **Clone / Salin Repository**:
   Letakkan folder proyek di dalam direktori server web Anda (contoh: `C:/laragon/www/hmjti_api` atau `C:/xampp/htdocs/hmjti_api`).

2. **Impor Database**:
   - Buka phpMyAdmin, DBeaver, atau MySQL CLI.
   - Buat database baru bernama `hmjti_member_management`.
   - Impor file SQL dari path: `database/hmjti_member_management.sql` (atau `hmjti_db.sql`).

3. **Aktifkan Modul Rewrite (Apache)**:
   Pastikan modul `mod_rewrite` pada web server Anda sudah aktif agar file `.htaccess` berfungsi dengan baik.

---

## 🗄️ Konfigurasi Database

Pengaturan database berada di file `config/database.php`. Sesuaikan kredensial server MySQL Anda:

```php
class Database {
    private $host = 'localhost';
    private $db_name = 'hmjti_member_management';
    private $username = 'root';
    private $password = 'password_db_anda';
    // ...
}
```

### Akun Administrator Default (Seed Data):
Secara bawaan, database telah dilengkapi akun penguji:
- **Admin / Sekretaris**: `admin@hmjti.ac.id` | Password: `password`
- **Ketua**: `ketua@hmjti.ac.id` | Password: `password`

---

## 📤 Format Respon Standar

Seluruh respon API dikembalikan dalam format **JSON** terstruktur konsisten:

### 1. Respon Sukses (200 / 201 OK)
```json
{
  "success": true,
  "message": "Pesan deskriptif keberhasilan",
  "data": { ... } // Berisi object atau array data (opsional)
}
```

### 2. Respon Gagal / Error (400 / 401 / 404 / 500)
```json
{
  "success": false,
  "message": "Pesan detail kegagalan"
}
```

---

## 📡 Dokumentasi API Endpoint

**Base URL**: `http://localhost/hmjti_api` (atau `http://localhost/backend`)

### 1. Autentikasi (Auth)

#### 🔑 Login Administrator
Digunakan untuk melakukan otentikasi akun admin/pengurus.

- **URL**: `/api/login` atau `/login`
- **Method**: `POST`
- **Headers**: `Content-Type: application/json`
- **Request Body**:
  ```json
  {
    "email": "admin@hmjti.ac.id",
    "password": "password"
  }
  ```
- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Login berhasil",
    "data": {
      "token": "e6a4b1c7890123456789abcdef...",
      "user": {
        "id": 1,
        "name": "Ahmad Rizal",
        "email": "admin@hmjti.ac.id",
        "role": "sekretaris"
      }
    }
  }
  ```
- **Respon Error (400 Bad Request / 401 Unauthorized)**:
  ```json
  {
    "success": false,
    "message": "Email atau password salah"
  }
  ```

---

#### 🚪 Logout
Digunakan untuk mengakhiri sesi pengguna.

- **URL**: `/api/logout` atau `/logout`
- **Method**: `POST`
- **Headers**: `Content-Type: application/json`
- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Logout berhasil"
  }
  ```

---

### 2. Dashboard & Statistik

#### 📊 Mendapatkan Statistik Dashboard
Mengembalikan angka ringkasan statistik anggota untuk tampilan dashboard.

- **URL**: `/api/dashboard` atau `/dashboard`
- **Method**: `GET`
- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Data statistik berhasil dimuat",
    "data": {
      "total_anggota": 10,
      "total_pengurus": 8,
      "total_angkatan": 4,
      "anggota_aktif": 9
    }
  }
  ```

---

### 3. Manajemen Anggota (Anggota)

#### 📋 1. Mendapatkan Daftar Anggota (List, Search & Filter)
Mengambil daftar seluruh anggota dengan opsi pencarian, pemfilteran, dan pengurutan.

- **URL**: `/api/anggota` atau `/anggota`
- **Method**: `GET`
- **Query Parameters** *(opsional)*:
  | Parameter | Tipe | Keterangan |
  | :--- | :--- | :--- |
  | `q` / `search` | string | Pencarian kata kunci pada Nama atau NIM |
  | `angkatan` | integer | Filter berdasarkan tahun angkatan (contoh: `2023`) |
  | `jabatan` | string | Filter berdasarkan jabatan (contoh: `Ketua`, `Anggota Biasa`) |
  | `status` | string | Filter status (`Aktif` atau `Non Aktif`) |
  | `sort` | string | Pilihan sort: `nama_asc` / `Nama A-Z`, `nama_desc` / `Nama Z-A`, `angkatan_desc` / `Angkatan Terbaru`, `angkatan_asc` / `Angkatan Terlama` |

- **Contoh Request**:
  `GET /api/anggota?search=Budi&status=Aktif&sort=nama_asc`

- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Data anggota berhasil dimuat",
    "data": [
      {
        "id": "1",
        "nama": "Budi Santoso",
        "nim": "11203362410001",
        "angkatan": "2023",
        "email": "budi.santoso@hmjti.ac.id",
        "nomor_hp": "081234567890",
        "jabatan": "Ketua",
        "status": "Aktif",
        "foto": "uploads/foto_1_1720000000.jpg",
        "created_at": "2026-08-13 10:00:00",
        "updated_at": "2026-08-13 10:00:00"
      }
    ]
  }
  ```

---

#### 👤 2. Detail Anggota
Mendapatkan informasi detail dari satu anggota berdasarkan ID.

- **URL**: `/api/anggota/{id}` (atau `/api/anggota?id={id}`)
- **Method**: `GET`
- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Detail anggota berhasil dimuat",
    "data": {
      "id": "1",
      "nama": "Budi Santoso",
      "nim": "11203362410001",
      "angkatan": "2023",
      "email": "budi.santoso@hmjti.ac.id",
      "nomor_hp": "081234567890",
      "jabatan": "Ketua",
      "status": "Aktif",
      "foto": null,
      "created_at": "2026-08-13 10:00:00",
      "updated_at": "2026-08-13 10:00:00"
    }
  }
  ```
- **Respon Error (404 Not Found)**:
  ```json
  {
    "success": false,
    "message": "Data tidak ditemukan"
  }
  ```

---

#### ➕ 3. Tambah Anggota Baru
Menambahkan data anggota baru ke dalam database.

- **URL**: `/api/anggota` atau `/anggota`
- **Method**: `POST`
- **Headers**: `Content-Type: application/json`
- **Request Body**:
  ```json
  {
    "nama": "Eka Putra",
    "nim": "11203362410011",
    "angkatan": 2024,
    "email": "eka.putra@hmjti.ac.id",
    "nomor_hp": "081299887766",
    "jabatan": "Anggota Biasa",
    "status": "Aktif",
    "foto": null
  }
  ```
- **Respon Sukses (201 Created)**:
  ```json
  {
    "success": true,
    "message": "Data berhasil ditambahkan",
    "data": {
      "id": "11"
    }
  }
  ```

---

#### ✏️ 4. Perbarui Data Anggota
Mengubah data anggota yang sudah tersimpan.

- **URL**: `/api/anggota/{id}` (atau `/api/anggota?id={id}`)
- **Method**: `PUT`
- **Headers**: `Content-Type: application/json`
- **Request Body**:
  ```json
  {
    "nama": "Eka Putra Perdana",
    "nim": "11203362410011",
    "angkatan": 2024,
    "email": "eka.putra@hmjti.ac.id",
    "nomor_hp": "081299887766",
    "jabatan": "Anggota Divisi Humas",
    "status": "Aktif"
  }
  ```
- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Data berhasil diubah"
  }
  ```

---

#### 🗑️ 5. Hapus Anggota
Menghapus data anggota berdasarkan ID.

- **URL**: `/api/anggota/{id}` (atau `/api/anggota?id={id}`)
- **Method**: `DELETE`
- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Data berhasil dihapus"
  }
  ```

---

#### 📷 6. Upload Foto Profil Anggota
Mengunggah file gambar untuk foto profil anggota.

- **URL**: `/api/anggota/upload/{id}` (atau `/api/anggota/upload?id={id}`)
- **Method**: `POST`
- **Headers**: `Content-Type: multipart/form-data`
- **Body Form-Data**:
  - `foto`: File Gambar (JPG / JPEG / PNG)
- **Respon Sukses (200 OK)**:
  ```json
  {
    "success": true,
    "message": "Foto berhasil diunggah",
    "data": {
      "file_name": "uploads/foto_11_1723545678.jpg"
    }
  }
  ```

---

## 🔒 Aturan Validasi Data

Saat menambah atau memperbarui data anggota, sistem menerapkan validasi ketat:

| Field | Aturan Validasi |
| :--- | :--- |
| `nama` | Wajib diisi, panjang **3 - 100 karakter** |
| `nim` | Wajib diisi, maksimal **30 karakter**, harus **unik** |
| `email` | Wajib diisi, format email valid (`filter_var`), harus **unik** |
| `nomor_hp` | Wajib diisi, panjang **10 - 15 digit** |
| `angkatan` | Wajib diisi (Tahun) |
| `jabatan` | Wajib salah satu dari: `Ketua`, `Wakil Ketua`, `Sekretaris`, `Bendahara`, `Koor Divisi Humas`, `Anggota Divisi Humas`, `Koor Divisi Minat & Bakat`, `Anggota Divisi Minat & Bakat`, `Anggota Biasa` |
| `status` | Wajib diisi, opsi: `Aktif` atau `Non Aktif` |

---

## 🗃️ Skema Database

### 1. Tabel `users`
Digunakan untuk autentikasi sistem.
```sql
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 2. Tabel `anggota`
Menyimpan data anggota HMJTI.
```sql
CREATE TABLE anggota (
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
```

---

## 📄 Lisensi & Hak Cipta
Dokumentasi dan proyek ini dikembangkan untuk kebutuhan internal **HMJTI (Himpunan Mahasiswa Jurusan Teknologi Informasi)**.
