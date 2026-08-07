class AppStrings {
  static const String appName = 'HMJTI Member Management';
  static const String appVersion = '1.0 (MVP)';
  static const String universityName = 'Universitas Sari Mulia';
  static const String organizationName = 'Himpunan Mahasiswa Jurusan Teknologi Informasi';
  
  // Auth Labels
  static const String loginTitle = 'Selamat Datang';
  static const String loginSubtitle = 'Masuk ke Sistem Manajemen Data Anggota HMJTI';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String loginButton = 'Login';
  static const String logoutButton = 'Logout';
  
  // Member Labels
  static const String nama = 'Nama Lengkap';
  static const String nim = 'NIM';
  static const String angkatan = 'Angkatan';
  static const String email = 'Email';
  static const String nomorHp = 'Nomor HP';
  static const String jabatan = 'Jabatan';
  static const String status = 'Status';
  static const String foto = 'Foto Anggota';

  // Button Texts
  static const String simpan = 'Simpan';
  static const String batal = 'Batal';
  static const String hapus = 'Hapus';
  static const String ubah = 'Ubah';
  static const String edit = 'Edit';
  static const String tambah = 'Tambah Anggota';
  static const String cari = 'Cari berdasarkan nama atau NIM...';
  
  // Validation Error Messages (PRD Section 10)
  static const String errorRequired = 'Field ini wajib diisi';
  static const String errorNamaMin = 'Nama minimal 3 karakter';
  static const String errorNamaMax = 'Nama maksimal 100 karakter';
  static const String errorNimMax = 'NIM maksimal 30 karakter';
  static const String errorEmailValid = 'Format email tidak valid';
  static const String errorPhoneDigit = 'Nomor HP harus 10-15 digit angka';
  static const String errorGeneral = 'Terjadi kesalahan. Silakan coba lagi.';
  static const String errorConnection = 'Gagal terhubung ke server.';
  
  // Lists matching PRD Section 9
  static const List<String> listJabatan = [
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
  
  static const List<String> listStatus = [
    'Aktif',
    'Non Aktif'
  ];

  static const List<String> listAngkatan = [
    '2023',
    '2024',
    '2025',
    '2026'
  ];
}
