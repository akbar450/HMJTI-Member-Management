class MemberModel {
  final int? id;
  final String nama;
  final String nim;
  final int angkatan;
  final String email;
  final String nomorHp;
  final String jabatan;
  final String status;
  final String? foto;
  final String? createdAt;
  final String? updatedAt;

  MemberModel({
    this.id,
    required this.nama,
    required this.nim,
    required this.angkatan,
    required this.email,
    required this.nomorHp,
    required this.jabatan,
    required this.status,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      nama: json['nama'] ?? json['nama_lengkap'] ?? '',
      nim: json['nim'] ?? '',
      angkatan: json['angkatan'] != null ? int.tryParse(json['angkatan'].toString()) ?? 2023 : 2023,
      email: json['email'] ?? '',
      nomorHp: json['nomor_hp'] ?? json['no_hp'] ?? '',
      jabatan: json['jabatan'] ?? 'Anggota Biasa',
      status: json['status'] ?? 'Aktif',
      foto: json['foto'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nama': nama,
      'nim': nim,
      'angkatan': angkatan,
      'email': email,
      'nomor_hp': nomorHp,
      'jabatan': jabatan,
      'status': status,
      if (foto != null) 'foto': foto,
    };
  }

  MemberModel copyWith({
    int? id,
    String? nama,
    String? nim,
    int? angkatan,
    String? email,
    String? nomorHp,
    String? jabatan,
    String? status,
    String? foto,
    String? createdAt,
    String? updatedAt,
  }) {
    return MemberModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nim: nim ?? this.nim,
      angkatan: angkatan ?? this.angkatan,
      email: email ?? this.email,
      nomorHp: nomorHp ?? this.nomorHp,
      jabatan: jabatan ?? this.jabatan,
      status: status ?? this.status,
      foto: foto ?? this.foto,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
