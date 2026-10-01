# 🚀 4-Month (120-Day) Continuous GitHub Contribution Roadmap
## Project: HMJTI Member Management App (Flutter + PHP Native REST API)

> **Tujuan**: Menjaga grafik kontribusi GitHub (Green Streak) tetap hijau tanpa terputus selama **4 bulan (120 hari berturut-turut)**, sekaligus mentransformasi aplikasi MVP ke tingkat Enterprise-grade.

---

## 📅 Strategi & Aturan Kontribusi Harian GitHub
1. **Setiap Hari (1 Commit / 1 Fitur Kecil)**: Kerjakan 1 tugas harian sesuai dengan jadwal di bawah ini.
2. **Standard Git Commit Message Format**:
   - `feat(theme): add dark theme provider and preferences persistence`
   - `fix(auth): update validation logic for NIM input`
   - `docs(roadmap): add 120-day contribution challenge roadmap`
3. **Commit ke Branch Main**: Pastikan commit di-push ke branch `main` atau dikirim via Pull Request agar dihitung di GitHub contribution graph.

---

## 🗓️ BULAN 1: Polish MVP, Theme & Core Enhancements (Hari 1 - 30)

| Hari | Modul / Topik | Rincian Tugas Harian |
| :--- | :--- | :--- |
| **Day 1** | **Theme & Settings** | Tambahkan `ThemeProvider` (Dark / Light Mode) & sinkronisasi `SharedPreferences`. |
| **Day 2** | **Theme UI Integration** | Tambahkan Switch Dark Mode di Profile Screen & App Bar theme toggle. |
| **Day 3** | **Export Feature Model** | Buat `ExportMemberModel` & helper format data CSV/JSON. |
| **Day 4** | **Backend CSV Export API** | Buat endpoint `backend/api/export_anggota.php` untuk unduh data CSV. |
| **Day 5** | **Flutter Export Service** | Tambahkan `ExportService` di Flutter untuk triggers download/share file CSV. |
| **Day 6** | **UI Export BottomSheet** | Buat `ExportModalBottomSheet` untuk opsi format file (CSV, JSON, Ringkasan PDF). |
| **Day 7** | **Skeleton Loading Shimmer** | Buat widget `MemberCardSkeleton` menggunakan efek shimmer animasi. |
| **Day 8** | **Dashboard Loading Shimmer** | Integrasikan shimmer loader di Dashboard stats card & statistik angkatan. |
| **Day 9** | **Advanced Search Filter** | Tambahkan filter pencarian berdasarkan Email & Nomor HP (Regex matcher). |
| **Day 10** | **Multi-Sorting Option** | Tambahkan opsi sorting (Nama A-Z, Z-A, Angkatan Terbaru, NIM Terurut). |
| **Day 11** | **Sort UI Modal** | Buat UI `SortBottomSheet` untuk memilih urutan data anggota. |
| **Day 12** | **Member Quick Share** | Tambahkan tombol Share Detail Anggota ke WhatsApp / Text format. |
| **Day 13** | **Empty State Enhancements** | Desain widget `CustomEmptyState` dengan ilustrasi & animasi interaktif. |
| **Day 14** | **Input Form Validation** | Tambahkan validator real-time untuk NIM (8-10 digit angka), Email, & Telp. |
| **Day 15** | **Form Error Feedback** | Tambahkan visual Error Banner & Snackbars kustom untuk umpan balik user. |
| **Day 16** | **Backend Request Rate Limiter** | Buat helper `RateLimiter.php` pada backend API untuk mencegah spam request. |
| **Day 17** | **API Logging System** | Tambahkan middleware logging request ke file `backend/logs/api.log`. |
| **Day 18** | **Member Avatar Initial Generator** | Buat helper widget `AvatarGenerator` jika foto profil anggota kosong. |
| **Day 19** | **Dashboard Quick Actions Bar** | Buat quick action bar di Dashboard (Tambah Anggota, Export, Filter, Refresh). |
| **Day 20** | **Pull to Refresh Polish** | Tambahkan haptic feedback & custom refresh indicator di Member List. |
| **Day 21** | **App Update Checker Service** | Buat mock `VersionCheckerService` untuk cek versi aplikasi terbaru. |
| **Day 22** | **App Version Dialog UI** | Buat modal `UpdateAvailableDialog` di Flutter. |
| **Day 23** | **Network Status Checker** | Tambahkan `ConnectivityService` untuk mendeteksi koneksi internet online/offline. |
| **Day 24** | **Offline Banner UI** | Tampilkan banner "Koneksi Terputus" di atas screen saat offline. |
| **Day 25** | **Profile Edit Enhancements** | Tambahkan form ubah Password Pengurus & konfirmasi password lama. |
| **Day 26** | **Backend Password Hash Check** | Buat endpoint `backend/api/change_password.php` dengan `password_verify`. |
| **Day 27** | **Unit Test Validation** | Buat file `test/validators_test.dart` untuk menguji validator NIM & Email. |
| **Day 28** | **Unit Test Member Model** | Buat `test/member_model_test.dart` untuk menguji parsing JSON. |
| **Day 29** | **API Response Normalization** | Standarisasi format error JSON backend (`success`, `code`, `message`, `data`). |
| **Day 30** | **Monthly Review & Docs** | Update `README.md` & ringkasan changelog rilis versi 1.1.0. |

---

## 🗓️ BULAN 2: Modul Keuangan & Uang Kas HMJTI (Hari 31 - 60)

| Hari | Modul / Topik | Rincian Tugas Harian |
| :--- | :--- | :--- |
| **Day 31** | **Database Schema Kas** | Buat file migration `backend/database/kas_tables.sql` (`t_kas`, `t_pembayaran_kas`). |
| **Day 32** | **Kas Backend Model** | Buat model PHP `backend/models/Kas.php` (query total pemasukan, saldo, tunggakan). |
| **Day 33** | **Kas Backend Controller** | Buat `backend/controllers/KasController.php` untuk logika keuangan. |
| **Day 34** | **Kas API Endpoints** | Buat file endpoint `backend/api/kas.php` (GET, POST, PUT, DELETE). |
| **Day 35** | **Kas Data Model Flutter** | Buat `lib/models/kas_model.dart` di aplikasi Flutter. |
| **Day 36** | **Kas Provider** | Buat `lib/providers/kas_provider.dart` dengan Provider state management. |
| **Day 37** | **Kas Service** | Buat `lib/services/kas_service.dart` untuk komunikasi HTTP API Keuangan. |
| **Day 38** | **Kas Main Screen** | Buat tampilan utama `lib/screens/kas/kas_screen.dart`. |
| **Day 39** | **Saldo & Summary Card** | Buat Widget `KasSummaryCard` (Total Kas, Kas Bulan Ini, Tunggakan). |
| **Day 40** | **Kas History List Item** | Buat widget `KasTransactionCard` (Icon kategori, tanggal, nominal, badge status). |
| **Day 41** | **Add Transaction Modal** | Buat Form `AddKasDialog` (Pilih Anggota, Nominal, Bulan, Keterangan). |
| **Day 42** | **Kas Category Filter** | Tambahkan filter transaksi (Pemasukan vs Pengeluaran). |
| **Day 43** | **Member Dues Matrix Model** | Buat model `MemberDuesStatusModel` untuk melihat status pembayaran 12 bulan. |
| **Day 44** | **Member Dues Grid Screen** | Buat screen `MemberDuesGridScreen` (Tabel status lunas/belum per anggota). |
| **Day 45** | **Dues Status Indicator** | Buat Chip indicator (Lunas = Hijau, Belum = Merah, Pending = Kuning). |
| **Day 46** | **Payment Receipt Upload API** | Buat endpoint backend `backend/api/upload_bukti_kas.php`. |
| **Day 47** | **Payment Proof Picker UI** | Tambahkan `ImagePicker` untuk memilih/mengambil foto bukti transfer kas. |
| **Day 48** | **Payment Proof Preview Screen** | Buat modal view gambar bukti pembayaran kas secara zoomed. |
| **Day 49** | **Kas Approval Backend API** | Buat endpoint `backend/api/approve_kas.php` untuk verifikasi pembayaran. |
| **Day 50** | **Kas Approval UI Badge** | Buat tombol Konfirmasi Pembayaran untuk Bendahara / Ketua. |
| **Day 51** | **Monthly Dues Reminder Helper**| Buat helper format pesan pengingat tagihan kas ke WhatsApp. |
| **Day 52** | **Financial Report Generator** | Buat helper `KasReportHelper` untuk menghitung neraca saldo bulanan. |
| **Day 53** | **Kas Search Bar** | Tambahkan pencarian transaksi kas berdasarkan nama anggota. |
| **Day 54** | **Kas Date Range Picker** | Buat filter rentang tanggal transaksi kas (Dari Tgl - Sampai Tgl). |
| **Day 55** | **Kas PDF Export Backend** | Buat generator ringkasan kas berbasis HTML/PDF di PHP backend. |
| **Day 56** | **Kas PDF View Screen** | Integrasikan viewer laporan kas di Flutter. |
| **Day 57** | **Kas Unit Test** | Buat `test/kas_provider_test.dart` menguji kalkulasi saldo. |
| **Day 58** | **Kas Dashboard Widget** | Integrasikan Ringkasan Uang Kas ke Dashboard Utama HMJTI. |
| **Day 59** | **Kas Security Validation** | Tambahkan proteksi hak akses edit kas hanya untuk akun Bendahara/Ketua. |
| **Day 60** | **Monthly Review & Docs** | Update `PRD.md` & rilis versi 1.2.0 (Modul Keuangan). |

---

## 🗓️ BULAN 3: Modul Program Kerja, Event & Absensi QR (Hari 61 - 90)

| Hari | Modul / Topik | Rincian Tugas Harian |
| :--- | :--- | :--- |
| **Day 61** | **Database Schema Event** | Buat file `backend/database/event_tables.sql` (`t_kegiatan`, `t_absensi`). |
| **Day 62** | **Event Backend Model** | Buat model PHP `backend/models/Event.php`. |
| **Day 63** | **Event Controller** | Buat `backend/controllers/EventController.php`. |
| **Day 64** | **Event API Endpoints** | Buat file endpoint `backend/api/events.php`. |
| **Day 65** | **Event Flutter Model** | Buat `lib/models/event_model.dart`. |
| **Day 66** | **Event Provider** | Buat `lib/providers/event_provider.dart`. |
| **Day 67** | **Event Service** | Buat `lib/services/event_service.dart`. |
| **Day 68** | **Event List Screen** | Buat `lib/screens/event/event_list_screen.dart`. |
| **Day 69** | **Event Card Widget** | Buat `EventCard` (Poster, Judul Proker, Tanggal, Lokasi, Status). |
| **Day 70** | **Event Detail Screen** | Buat `lib/screens/event/event_detail_screen.dart`. |
| **Day 71** | **Add Event Form UI** | Buat Form Tambah Kegiatan (Nama Proker, Tanggal, Kuota, Panitia PIC). |
| **Day 72** | **Member QR Code Generator** | Tambahkan generator QR Code ID Anggota berbasis NIM di Profil. |
| **Day 73** | **Event QR Code Pass** | Tambahkan tiket/pass QR Code untuk kehadiran event. |
| **Day 74** | **QR Scanner Dependency** | Konfigurasi package QR Scanner di Flutter `pubspec.yaml`. |
| **Day 75** | **QR Scanner Screen** | Buat screen `lib/screens/event/qr_scanner_screen.dart`. |
| **Day 76** | **Absensi API Backend** | Buat endpoint `backend/api/submit_absensi.php` via NIM/QR scanner. |
| **Day 77** | **Absensi Realtime List UI** | Buat tab "Kehadiran Realtime" di Event Detail Screen. |
| **Day 78** | **Absensi Stats Card** | Tampilkan statistik persentase kehadiran (Hadir, Izin, Alpa). |
| **Day 79** | **Manual Absensi Input** | Buat modal input manual kehadiran jika QR scanner tidak digunakan. |
| **Day 80** | **E-Certificate Model** | Buat `CertificateModel` untuk sertifikat kepanitiaan/peserta. |
| **Day 81** | **Certificate Template Asset**| Tambahkan asset template sertifikat di `assets/images/cert_template.png`. |
| **Day 82** | **Certificate Generator** | Buat helper render Sertifikat Digital dengan nama anggota & peran. |
| **Day 83** | **Certificate Preview UI** | Buat preview screen untuk download / share sertifikat PDF/PNG. |
| **Day 84** | **Event Status Filter** | Filter kegiatan (Akan Datang, Berlangsung, Selesai). |
| **Day 85** | **Event Budget Tracking** | Tambahkan input anggaran proker vs realisasi pengeluaran event. |
| **Day 86** | **Event Attendance Export** | Buat endpoint export rekap kehadiran event ke file Excel/CSV. |
| **Day 87** | **Event Unit Tests** | Buat unit test `test/event_provider_test.dart`. |
| **Day 88** | **Event Calendar View** | Buat tampilan Kalender Proker HMJTI bulanan. |
| **Day 89** | **Dashboard Event Widget** | Tambahkan widget "Event Terdekat" pada Dashboard Utama. |
| **Day 90** | **Monthly Review & Docs** | Update `PRD.md` & rilis versi 1.3.0 (Modul Event & Absensi). |

---

## 🗓️ BULAN 4: Security, Audit Trail, Offline Cache & Release v2.0 (Hari 91 - 120)

| Hari | Modul / Topik | Rincian Tugas Harian |
| :--- | :--- | :--- |
| **Day 91** | **Audit Log Schema** | Buat file `backend/database/audit_tables.sql` (`t_log_aktivitas`). |
| **Day 92** | **Audit Logger Middleware** | Buat middleware PHP untuk mencatat setiap aktivitas INSERT/UPDATE/DELETE. |
| **Day 93** | **Audit Log API Endpoint** | Buat endpoint `backend/api/audit_logs.php`. |
| **Day 94** | **Audit Log Model Flutter** | Buat `lib/models/audit_log_model.dart`. |
| **Day 95** | **Audit Log Screen UI** | Buat `lib/screens/admin/audit_log_screen.dart` khusus role Ketua. |
| **Day 96** | **Role Authorization Check**| Perketat pembatasan hak akses (Ketua vs Sekretaris vs Bendahara vs Anggota). |
| **Day 97** | **Departemen Model & API** | Buat endpoint & model Struktur Divisi HMJTI (BPH, Ristek, Humas, dll.). |
| **Day 98** | **Division Tree View UI** | Buat screen Struktur Organisasi HMJTI dengan hierarki visual. |
| **Day 99** | **Offline Caching Service** | Implementasikan caching data anggota ke `SharedPreferences` / Local Storage. |
| **Day 100**| **Cache Invalidation Policy**| Tambahkan logika refresh cache saat internet kembali online. |
| **Day 101**| **App Security Helper** | Enkripsi data sensitif (Token / Session) di local storage. |
| **Day 102**| **SQL Injection Prevention** | Audit seluruh query PHP Native backend agar menggunakan Prepared Statements. |
| **Day 103**| **CORS & Headers Security** | Hardening headers HTTP pada backend PHP (`X-Content-Type-Options`, `X-Frame-Options`). |
| **Day 104**| **API Rate Limit UI Alert**| Tampilkan dialog "Terlalu banyak permintaan, coba lagi nanti" saat 429. |
| **Day 105**| **Custom Font & Typography**| Fine-tuning typography hierarchy dengan Google Fonts Inter & Poppins. |
| **Day 106**| **Micro-Animations Polish**| Tambahkan animasi transisi halus (`Hero`, `AnimatedContainer`, `FadeTransition`). |
| **Day 107**| **App Icon Customization** | Update aset ikon launcher Android & iOS untuk versi rilis 2.0. |
| **Day 108**| **Splash Screen Refresh** | Refactor splash screen dengan animasi branding HMJTI terbaru. |
| **Day 109**| **Widget Test Member Card** | Buat test file `test/widget_member_card_test.dart`. |
| **Day 110**| **Widget Test Stats Card** | Buat test file `test/widget_stats_card_test.dart`. |
| **Day 111**| **Integration Test Login** | Buat integration test flow login pengguna. |
| **Day 112**| **GitHub Actions CI Setup** | Buat `.github/workflows/flutter_ci.yml` untuk otomatisasi test & build. |
| **Day 113**| **GitHub Actions Linter** | Tambahkan linter step `flutter analyze` pada pipeline CI. |
| **Day 114**| **Swagger / OpenAPI Spec** | Buat dokumentasi API `docs/openapi.yaml`. |
| **Day 115**| **User Manual Document** | Buat dokumen panduan pengguna `docs/USER_GUIDE.md`. |
| **Day 116**| **Backend Performance Benchmark**| Optimize query SQL & indeks tabel database MySQL. |
| **Day 117**| **APK Build Optimization** | Konfigurasi proguard & shrink code untuk build APK Android terkompresi. |
| **Day 118**| **Final QA Audit** | Pengujian komprehensif seluruh fitur (Anggota, Kas, Event, Audit Log). |
| **Day 119**| **Release v2.0 Notes** | Tulis catatan rilis resmi & changelog v2.0 di `CHANGELOG.md`. |
| **Day 120**| **Challenge Completed! 🏆**| Tag git commit `v2.0.0-final`, selebrasi 120 hari GitHub Green Streak! |

---

## 🛠️ Cara Menggunakan Antigravity Setiap Hari:
Setiap hari, buka project ini dan katakan ke Antigravity:
> *"Jalankan tugas Day X dari ROADMAP_4_MONTHS.md"*

Antigravity akan langsung mengimplementasikan fitur tersebut dan membuat git commit untuk hari itu.
