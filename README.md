# 📱 HMJTI Member Management App

> **Sistem Informasi Manajemen Data Anggota HMJTI Universitas Sari Mulia**  
> Aplikasi mobile berbasis Android yang dibangun dengan **Flutter** dan **PHP Native REST API** untuk mengelola data anggota Himpunan Mahasiswa Jurusan Teknologi Informasi secara terpusat, efisien, dan modern.

---

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![PHP](https://img.shields.io/badge/PHP-Native_REST_API-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net)
[![MySQL](https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com)
[![Status](https://img.shields.io/badge/Status-MVP_1.0_Final-2EA44F?style=for-the-badge)](#)

---

## 📌 Daftar Isi
- [Tentang Aplikasi](#-tentang-aplikasi)
- [Latar Belakang & Masalah](#-latar-belakang--masalah)
- [Fitur Utama](#-fitur-utama)
- [Arsitektur & Tech Stack](#-arsitektur--tech-stack)
- [Struktur Direktori Proyek](#-struktur-direktori-proyek)
- [Panduan Instalasi & Konfigurasi](#-panduan-instalasi--konfigurasi)
  - [1. Persiapan Backend & Database](#1-persiapan-backend--database)
  - [2. Persiapan Frontend (Flutter)](#2-persiapan-frontend-flutter)
- [Dokumentasi API (REST Endpoints)](#-dokumentasi-api-rest-endpoints)
- [Profil Pengembang](#-profil-pengembang)

---

## 📖 Tentang Aplikasi

**HMJTI Member Management** adalah aplikasi mobile berbasis Flutter yang dirancang untuk mendukung operasional administrasi pengurus Himpunan Mahasiswa Jurusan Teknologi Informasi (HMJTI) Universitas Sari Mulia. 

Aplikasi ini merupakan hasil implementasi dari **Enterprise Architecture (EA)** HMJTI menggunakan framework **TOGAF ADM** (*Business Architecture* & *Information Systems Architecture*). Aplikasi ini berfungsi sebagai solusi terpusat untuk mendokumentasikan, mencari, serta mengelola data keanggotaan secara digital.

---

## 🎯 Latar Belakang & Masalah

### Permasalahan Sebelum Ada Aplikasi:
* 📑 **Data Tersebar**: Pendataan anggota tersimpan di spreadsheet pribadi, dokumen acak, dan obrolan grup WhatsApp.
* ❌ **Duplikasi Data & Inkonsistensi**: Tidak ada sumber data resmi (*Single Source of Truth*).
* 🔍 **Pencarian Lambat**: Membutuhkan waktu lama untuk mencari data anggota atau pengurus tertentu.
* 📦 **Data Hilang Saat Pergantian Kepengurusan**: Informasi anggota lama sering kali hilang ketika periode pengurus berganti.

### Solusi yang Dihadirkan:
* 🌐 Database terpusat berbasis MySQL yang dapat diakses melalui REST API.
* 📲 Aplikasi mobile interaktif, cepat, dan mudah digunakan oleh pengurus (Ketua & Sekretaris).
* ⚡ Fitur pencarian *realtime* dan pemfilteran bertingkat (Angkatan, Jabatan, Status).

---

## ✨ Fitur Utama

| Fitur | Deskripsi |
|---|---|
| 🔐 **Autentikasi Pengguna** | Login & Logout aman menggunakan kredensial pengurus (Ketua / Sekretaris) yang terverifikasi di MySQL. |
| 📊 **Dashboard Statistik** | Ringkasan realtime total anggota, jumlah pengurus, statistik angkatan, dan anggota aktif. |
| 📋 **Daftar Anggota** | Menampilkan seluruh anggota dengan tampilan card interaktif, foto profil, dan indikator status. |
| ➕ **Tambah Data Anggota** | Form pendaftaran anggota baru lengkap dengan input NIM, Nama, Angkatan, Jabatan, Status, Kontak, & Upload Foto. |
| ✏️ **Edit & Detail Anggota** | Mengubah informasi anggota secara fleksibel dan melihat detail profil lengkap. |
| 🗑️ **Hapus Data Anggota** | Penghapusan data anggota disertai dialog konfirmasi keamanan. |
| 🔍 **Realtime Search** | Pencarian instan data anggota berdasarkan **Nama** atau **NIM**. |
| 🎛️ **Multi-Filtering** | Filter kombinasi berdasarkan **Angkatan**, **Jabatan**, dan **Status Keanggotaan**. |
| 👤 **Profil Pengguna & App Info** | Menampilkan info akun login aktif serta rincian versi aplikasi. |

---

## 🛠️ Arsitektur & Tech Stack

### 📱 Frontend (Mobile App)
* **Framework**: Flutter (Dart ^3.11)
* **State Management**: `provider` (^6.1.0)
* **UI & Typography**: Material Design 3, Google Fonts (`Inter` / `Outfit`), `cupertino_icons`
* **Networking**: `http` (^1.1.0)
* **Media Handling**: `image_picker` (^1.0.0), `cached_network_image` (^3.3.0)
* **Storage & Utils**: `shared_preferences` (^2.2.0), `intl` (^0.19.0)

### 🖥️ Backend (REST API)
* **Bahasa & Architecture**: PHP Native (Clean Architecture: Controller, Model, Helper, Response Format)
* **Web Server**: Apache (Laragon / XAMPP)
* **Format Data**: JSON Format dengan standar HTTP Status Codes & CORS Headers Enabled

### 🗄️ Database
* **DBMS**: MySQL / MariaDB
* **Database Name**: `hmjti_db`

---

## 📂 Struktur Direktori Proyek

```text
project_uas_flutter/
├── android/                  # Configuration & Native Android Files
├── assets/                   # App Assets (Images, Icons, Logos)
├── backend/                  # Backend REST API Source Code (PHP)
│   ├── api/                  # API Endpoints (anggota.php, login.php, dashboard.php, dll.)
│   ├── config/               # Database Connection & Configuration
│   ├── controllers/          # Business Logic Controllers
│   ├── database/             # Migration & Seeder scripts
│   ├── helpers/              # Utility Helpers (Response Formatters, CORS)
│   ├── models/               # Data Models & Query Logic
│   └── hmjti_db.sql          # Database Dump SQL File
├── docs/                     # Documentation Files
│   └── PRD.md                # Product Requirements Document (PRD)
├── lib/                      # Flutter Application Core Code
│   ├── main.dart             # Application Entry Point
│   ├── app.dart              # MaterialApp & Route Configuration
│   ├── core/                 # App Constants, Themes, & Configurations
│   │   ├── config/           # App Constants & App Config
│   │   ├── constants/        # API Constants, Colors, Strings
│   │   └── theme/            # Material Theme Data
│   ├── models/               # Data Models (MemberModel, UserModel, DashboardStatsModel)
│   ├── providers/            # State Management (AuthProvider, MemberProvider, DashboardProvider)
│   ├── screens/              # UI Screens (Auth, Dashboard, Member List, Member Form, Profile)
│   ├── services/             # API Services (ApiService, AuthService, MemberService)
│   ├── utils/                # Helper Functions & Validators
│   └── widgets/              # Reusable UI Components (MemberCard, FilterBottomSheet, StatsCard, dll.)
├── pubspec.yaml              # Flutter Dependencies & Package Config
└── README.md                 # Documentation File
```

---

## 🚀 Panduan Instalasi & Konfigurasi

### Prasyarat System:
* **Flutter SDK**: `^3.11.5` atau versi terbaru
* **PHP**: `^8.0`
* **Web Server & Database**: Laragon / XAMPP (Apache & MySQL)
* **IDE**: VS Code / Android Studio

---

### 1. Persiapan Backend & Database

1. **Jalankan Web Server & MySQL**:
   Buka Laragon / XAMPP dan jalankan service **Apache** & **MySQL**.

2. **Import Database**:
   * Buka phpMyAdmin (`http://localhost/phpmyadmin`) atau DBeaver/Navicat.
   * Buat database baru dengan nama `hmjti_db`.
   * Import file database yang berada pada path:
     `backend/hmjti_db.sql`

3. **Salin / Endpoint Backend**:
   * Pastikan folder `backend/` dapat diakses melalui localhost web server.  
   * Tempatkan folder `backend` di directory root Laragon (`C:\laragon\www\backend`) atau XAMPP (`htdocs/backend`).
   * Test akses API pada browser:  
     `http://localhost/backend/api/dashboard.php`

---

### 2. Persiapan Frontend (Flutter)

1. **Clone / Buka Project**:
   Buka folder `project_uas_flutter` di VS Code / Android Studio.

2. **Install Dependencies**:
   Jalankan perintah berikut di terminal:
   ```bash
   flutter pub get
   ```

3. **Konfigurasi IP Backend**:
   Buka file [api_constants.dart](file:///c:/Users/PC/Documents/project_uas_flutter/lib/core/constants/api_constants.dart) dan sesuaikan `baseUrl` dengan alamat IP komputer/emulator Anda:
   * **Emulator Android Default**: `http://10.0.2.2/backend/api`
   * **Perangkat HP Fisik**: `http://<IP_LAPTOP_ANDA>/backend/api` (Pastikan HP dan Laptop terhubung di jaringan Wi-Fi yang sama)

4. **Jalankan Aplikasi**:
   ```bash
   flutter run
   ```

---

## 📡 Dokumentasi API (REST Endpoints)

| Method | Endpoint | Deskripsi | Authentication |
|---|---|---|---|
| `POST` | `/login.php` | Authenticasi Login Pengurus (Ketua/Sekretaris) | No |
| `POST` | `/logout.php` | Logout Pengguna Active Session | Yes |
| `GET` | `/dashboard.php` | Mengambil data ringkasan & statistik dashboard | Yes |
| `GET` | `/anggota.php` | Mengambil seluruh daftar anggota (Support search & filter) | Yes |
| `GET` | `/anggota.php?id={id}` | Mengambil detail anggota berdasarkan ID | Yes |
| `POST` | `/anggota.php` | Menambahkan anggota baru | Yes |
| `PUT` | `/anggota.php?id={id}` | Mengbarui data anggota | Yes |
| `DELETE` | `/anggota.php?id={id}` | Menghapus data anggota | Yes |

---

## 👤 Profil Pengembang

* **Nama**: Suraya Akbar
* **Organisasi**: Himpunan Mahasiswa Jurusan Teknologi Informasi (HMJTI)
* **Institusi**: Universitas Sari Mulia
* **Tujuan Proyek**: Tugas Akhir / UAS & Implementasi Enterprise Architecture HMJTI

---

<p align="center">
  <b>HMJTI Universitas Sari Mulia</b> • 2026
</p>
